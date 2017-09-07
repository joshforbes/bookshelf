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

  describe '#token_matching' do
    it 'returns an active token that matches the provided token string' do
      user = create(:user)
      token = create(:token, user: user)

      found_token = user.token_matching(token.body)

      expect(found_token.body).to eq(token.body)
    end

    it 'returns a null token if there is no matching active token' do
      user = create(:user)

      found_token = user.token_matching('not-the-correct-body')

      expect(found_token).to be_an_instance_of(Users::NullToken)
    end
  end

  describe '#can_rent?' do
    it 'is true if the user has not exceeded the maximum rentals' do
      user = create(:user)

      can_rent = user.can_rent?

      expect(can_rent).to be(true)
    end

    it 'is false if the user has not exceeded the maximum rentals' do
      user = create(:user)
      create_list(:rental, Users::User::MAXIMUM_RENTALS, user: user)

      can_rent = user.can_rent?

      expect(can_rent).to be(false)
    end
  end
end
