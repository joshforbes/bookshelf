module Rentals
  class Rental < ApplicationRecord
    belongs_to :user, class_name: 'Users::User'
    belongs_to :book, class_name: 'Books::Book'

    validates :user, :book, :rented_at, presence: true
    validate :item_is_rentable
    validate :user_can_rent

    private

    def item_is_rentable
      errors.add(:base, 'Item is not available for rent at this time') unless book&.rentable?
    end

    def user_can_rent
      errors.add(:base, 'User is not eligible to rent at this time') unless user&.can_rent?
    end
  end
end
