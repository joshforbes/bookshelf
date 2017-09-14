require 'rails_helper'

RSpec.describe 'Session API', type: :request do
  describe 'POST #create' do
    it 'should authenticate the user and return their token' do
      user = create(:user)

      post sessions_url, params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:ok)
      expect(json_response['token']).to eq(user.tokens.first.body)
    end

    it 'does not authenticate with an invalid email' do
      post sessions_url, params: { email: 'invalid@email.com', password: 'Invalid Password' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'does not authenticate with an invalid password' do
      user = create(:user)

      post sessions_url, params: { email: user.email, password: 'Invalid Password' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy the current users token' do
      user = create(:user)
      token = create(:token, user_id: user.id)

      delete sessions_url, headers: {
        HTTP_AUTHORIZATION: token.body,
        HTTP_USER_EMAIL: user.email
      }

      expect(response).to have_http_status(:no_content)
      expect(Users::Token.count).to eq(0)
    end
  end
end
