require 'rails_helper'

RSpec.describe Users::User, type: :model do
  describe '#valid?' do
    before(:each) do
      @user = build(:user)
    end

    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'is valid with a new valid password' do
      @user.password = 'New Password'

      expect(@user).to be_valid
    end

    it 'is not valid without a password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end

    it 'is not valid with a short password' do
      @user.password = 'short'
      expect(@user).not_to be_valid
    end

    it 'is not valid if email is not unique' do
      another_user = create(:user)
      @user.email = another_user.email
      expect(@user).not_to be_valid
    end

    it 'is not valid if display_name is not unique' do
      another_user = create(:user)
      @user.display_name = another_user.display_name
      expect(@user).not_to be_valid
    end
  end
end
