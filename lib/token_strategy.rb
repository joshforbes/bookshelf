class TokenStrategy < ::Warden::Strategies::Base
  FAILURE_MESSAGE = 'Authentication failed'

  def valid?
    user_email_from_headers.present? && token_from_headers.present?
  end

  def authenticate!
    user = Users::User.find_by_email(user_email_from_headers)
    return fail!(FAILURE_MESSAGE) unless user

    token = user.token_matching(token_from_headers)
    if token.use
      success!(user)
    else
      fail!(FAILURE_MESSAGE)
    end
  end

  def store?
    false
  end

  private

  def user_email_from_headers
    env['HTTP_USER_EMAIL']
  end

  def token_from_headers
    env['HTTP_AUTHORIZATION']
  end
end