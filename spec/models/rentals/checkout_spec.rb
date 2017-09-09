require 'rails_helper'

RSpec.describe Rentals::Checkout do
  describe '#valid?' do
    before(:each) do
      book = mock_model(Books::Book, rentable?: true)
      user = mock_model(Users::User, can_rent?: true)
      @checkout = Rentals::Checkout.new(book: book, user: user)
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
      book = double(rentable?: false)
      @checkout.book = book

      expect(@checkout).not_to be_valid
    end

    it 'is not valid with a user that cannot rent' do
      user = double(can_rent?: false)
      @checkout.user = user

      expect(@checkout).not_to be_valid
    end
  end

  describe '#save?' do
    it 'persists a new rental' do
      book = create(:book)
      user = create(:user)
      checkout = Rentals::Checkout.new(book_id: book.id, user_id: user.id)

      checkout.save

      rental = checkout.rental
      expect(rental.book_id).to eq(book.id)
      expect(rental.user_id).to eq(user.id)
      expect(rental.persisted?).to be(true)
    end

    it 'returns false if invalid' do
      book = double(rentable?: false)
      user = build(:user)
      checkout = Rentals::Checkout.new(book: book, user: user)

      checkout.save

      expect(checkout.rental).to be(nil)
      expect(checkout.errors.any?).to be(true)
    end
  end
end
