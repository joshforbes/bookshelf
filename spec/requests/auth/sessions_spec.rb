require 'rails_helper'

RSpec.describe 'Session API', type: :request do
  describe 'POST #create' do
    it 'should authenticate the user and return their token' do
      user = create(:user)

      post sessions_url, params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:ok)
      expect(json_response['token']).to eq(user.auth_token)
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
      original_token = user.auth_token

      delete sessions_url, headers: auth_headers(user)

      expect(response).to have_http_status(:no_content)
      expect(user.reload.auth_token).to_not eq(original_token)
    end
  end
end