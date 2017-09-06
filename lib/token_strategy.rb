class TokenStrategy < ::Warden::Strategies::Base
  FAILURE_MESSAGE = 'Authentication failed'

  def valid?
    user_email_from_headers.present? && token_from_headers.present?
  end

  def authenticate!
    user = Users::User.find_by_email(user_email_from_headers)
    return fail!(FAILURE_MESSAGE) unless user

    token = Users::Token.new(user)
    if token.compare_to(token_from_headers) && token.active?
      token.use
      return success!(user)
    end

    token.regenerate
    fail!(FAILURE_MESSAGE)
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