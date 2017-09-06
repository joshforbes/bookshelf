module RequestHelper
  def json_response
    JSON.parse(response.body)
  end

  def auth_headers(user)
    {
      'HTTP_AUTHORIZATION': user.auth_token,
      'HTTP_USER_EMAIL': user.email
    }
  end
end