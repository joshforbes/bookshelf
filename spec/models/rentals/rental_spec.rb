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

  describe '.overdue' do
    it 'can find rentals that are past their due date' do
      rental = create(:rental, rented_at: 30.days.ago)

      found_rental = Rentals::Rental.overdue.first

      expect(found_rental.id).to eq(rental.id)
    end

    it 'does not find rentals that are not past their due date' do
      create(:rental, rented_at: Rentals::Rental::DURATION_IN_DAYS.ago + 1.day)

      found_rental = Rentals::Rental.overdue.first

      expect(found_rental).to be(nil)
    end
  end

  describe '#check_in' do
    it 'set the returned_at to the current date' do
      rental = create(:rental)

      rental = rental.check_in

      expect(rental.returned_at).to eq(Date.current)
    end

    it 'does not set the returned_at if the rental has already been returned' do
      rental = create(:rental, returned_at: Date.yesterday)

      rental = rental.check_in

      expect(rental.returned_at).to eq(Date.yesterday)
    end
  end

  describe '#default_values' do
    it 'initializes with a rented_at of today' do
      rental = Rentals::Rental.new

      expect(rental.rented_at).to eq(Date.current)
    end
  end
end
