module RequestHelper
  def json_response
    JSON.parse(response.body)
  end

  def acting_as(user)
    auth_headers(user, user.tokens.first || user.tokens.create)
  end

  def auth_headers(user, token)
    {
      'HTTP_USER_EMAIL': user.email,
      'HTTP_AUTHORIZATION': token.body
    }
  end
end
