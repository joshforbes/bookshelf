require 'rails_helper'

RSpec.describe Rentals::Checkout do
  describe '#valid?' do
    before(:each) do
      book = mock_model(Books::Book, rentable?: true)
      user = mock_model(Users::User, can_rent?: true)
      @checkout = Rentals::Checkout.new(book, user)
    end

    it 'is valid with valid attributes' do
      expect(@checkout).to be_valid
    end

    it 'is not valid without a book' do
      @checkout.book = nil
      expect(@checkout).not_to be_valid
    end

    it 'is not valid without a user' do
      @checkout.user = nil
      expect(@checkout).not_to be_valid
    end

    it 'is not valid with an book that is not rentable' do
      book = mock_model(Books::Book, rentable?: false)
      @checkout.book = book

      expect(@checkout).not_to be_valid
    end

    it 'is not valid with a user that cannot rent' do
      user = mock_model(Users::User, can_rent?: false)
      @checkout.user = user

      expect(@checkout).not_to be_valid
    end
  end
end
