require 'rails_helper'

RSpec.describe Users::NullToken, type: :model do
  describe '#user' do
    it 'cannot be used' do
      token = Users::NullToken.new

      used = token.use

      expect(used).to be(false)
    end
  end

  describe '#use' do
    it 'cannot be used' do
      token = Users::NullToken.new

      used = token.use

      expect(used).to be(false)
    end
  end

  describe '#equal_to?' do
    it 'is never equal to a token string' do
      token = Users::NullToken.new

      equal = token.equal_to?('not-going-to-work')

      expect(equal).to be(false)
    end
  end

  describe '#active?' do
    it 'is never active' do
      token = Users::NullToken.new

      equal = token.active?

      expect(equal).to be(false)
    end
  end
end
