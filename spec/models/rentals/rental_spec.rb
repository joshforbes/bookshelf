require 'rails_helper'

RSpec.describe Rentals::Rental, type: :model do
  describe '#valid?' do
    before(:each) do
      @rental = build_stubbed(:rental)
    end

    it 'is valid with valid attributes' do
      expect(@rental).to be_valid
    end

    it 'is not valid without a user' do
      @rental.user = nil
      expect(@rental).not_to be_valid
    end

    it 'is not valid without a book' do
      @rental.book = nil
      expect(@rental).not_to be_valid
    end

    it 'is not valid without a rented_at' do
      @rental.rented_at = nil
      expect(@rental).not_to be_valid
    end

    it 'is not valid with an book that is not rentable' do
      book = mock_model(Books::Book, rentable?: false)
      @rental.book = book

      expect(@rental).not_to be_valid
    end

    it 'is not valid with a user that cannot rent' do
      user = mock_model(Users::User, can_rent?: false)
      @rental.user = user

      expect(@rental).not_to be_valid
    end
  end

  describe '.active' do
    it 'can find rentals that have not been returned' do
      rental = create(:rental, returned_at: nil)

      found_rental = Rentals::Rental.active.first

      expect(found_rental.id).to eq(rental.id)
    end

    it 'does not find returned rentals' do
      create(:rental, returned_at: Date.current)

      found_rental = Rentals::Rental.active.first

      expect(found_rental).to be(nil)
    end
  end
end
