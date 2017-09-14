require 'rails_helper'
require_relative '../../lib/token_strategy'

RSpec.describe TokenStrategy do
  it 'is valid if valid credentials' do
    ENV['HTTP_USER_EMAIL'] = 'test@test.com'
    ENV['HTTP_AUTHORIZATION'] = 'abcdef'
    strategy = TokenStrategy.new(ENV)

    valid = strategy.valid?

    expect(valid).to be(true)
  end

  it 'succeeds with valid email and token' do
    user = create(:user)
    token = create(:token, user_id: user.id)
    ENV['HTTP_USER_EMAIL'] = user.email
    ENV['HTTP_AUTHORIZATION'] = token.body
    strategy = TokenStrategy.new(ENV)

    auth_status = strategy.authenticate!

    expect(auth_status).to eq(:success)
  end

  it 'fails if the email does not exist' do
    ENV['HTTP_USER_EMAIL'] = 'test@test.com'
    strategy = TokenStrategy.new(ENV)

    auth_status = strategy.authenticate!

    expect(auth_status).to eq(:failure)
  end

  it 'fails if the tokens do not match' do
    user = create(:user)

    ENV['HTTP_USER_EMAIL'] = user.email
    ENV['HTTP_AUTHORIZATION'] = 'abcdef'
    strategy = TokenStrategy.new(ENV)

    auth_status = strategy.authenticate!

    expect(auth_status).to eq(:failure)
  end
end
