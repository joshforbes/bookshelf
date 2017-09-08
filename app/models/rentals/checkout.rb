module Rentals
  class Checkout
    include ActiveModel::Validations

    validates :book_id, :user_id, presence: true
    validate :item_is_rentable
    validate :user_can_rent

    attr_accessor :book, :user

    def initialize(book_id, user_id)
      @book = Books::Book.find(book_id)
      @user = Users::User.find(user_id)
    end

    private

    def item_is_rentable
      errors.add(:base, 'Item is not available for rent at this time') unless book&.rentable?
    end

    def user_can_rent
      errors.add(:base, 'User is not eligible to rent at this time') unless user&.can_rent?
    end
  end
end