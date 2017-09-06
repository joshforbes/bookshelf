require 'rails_helper'

RSpec.describe Users::Token, type: :model do
  it 'can get the body' do
    user = create(:user)
    token = Users::Token.new(user)

    body = token.body

    assert_equal(user.auth_token, body)
  end

  it 'can get the last used at' do
    user = create(:user)
    token = Users::Token.new(user)

    last_used_at = token.last_used_at

    expect(user.token_last_used_at).to eq(last_used_at)
  end

  it 'can regenerate the body' do
    user = create(:user)
    token = Users::Token.new(user)
    old_token_body = token.body

    token.regenerate

    expect(token.body).to_not eq(old_token_body)
  end

  it 'is active if not expired' do
    user = create(:user)
    token = Users::Token.new(user)

    active = token.active?

    expect(active).to be(true)
  end

  it 'sets the last_used_at to now when used' do
    user = create(:user, token_last_used_at: 10.days.ago)
    token = Users::Token.new(user)

    token.use

    expect(user.token_last_used_at.to_date).to eq(Time.current.to_date)
  end

  it 'knows if it is equal to a token string' do
    user = create(:user)
    token = Users::Token.new(user)

    is_equal = token.compare_to(user.auth_token)

    expect(is_equal).to be(true)
  end

  it 'knows if it is not equal to a token string' do
    user = create(:user)
    token = Users::Token.new(user)

    is_equal = token.compare_to('not-equal')

    expect(is_equal).to_not be(true)
  end
end