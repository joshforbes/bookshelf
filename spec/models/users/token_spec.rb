require 'rails_helper'

RSpec.describe Users::Token, type: :model do
  describe '.active?' do
    it 'can find active tokens' do
      token = create(:token, last_used_at: Time.now)

      found_token = Users::Token.active.first

      expect(found_token.id).to eq(token.id)
    end

    it 'does not find expired tokens' do
      create(:token, last_used_at: 10.days.ago)

      found_token = Users::Token.active.first

      expect(found_token).to be(nil)
    end
  end

  describe '#use' do
    it 'returns true if the token is not expired' do
      token = create(:token, last_used_at: Time.now)

      used = token.use

      expect(used).to be(true)
    end

    it 'updates the last_used_at if the token can be used' do
      token = create(:token, last_used_at: 5.days.ago)

      token.use

      expect(token.last_used_at.to_date).to eq(Time.current.to_date)
    end

    it 'returns false if the token is not active' do
      token = build_stubbed(:token, last_used_at: 10.days.ago)

      used = token.use

      expect(used).to be(false)
    end
  end

  describe '#is_equal_to?' do
    it 'returns true if the token body is the same as the provided string' do
      token = create(:token)

      equal = token.is_equal_to?(token.body)

      expect(equal).to be(true)
    end

    it 'returns false if the token body is different than the provided string' do
      token = create(:token)

      equal = token.is_equal_to?('not the same')

      expect(equal).to be(false)
    end
  end
end