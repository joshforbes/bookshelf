module Rentals
  class Checkout
    include ActiveModel::Validations

    validates :book, :user, presence: true
    validate :item_is_rentable
    validate :user_can_rent

    attr_accessor :book, :user, :rental

    def initialize(params)
      @book = params[:book] || Books::Book.find(params[:book_id])
      @user = params[:user] || Users::User.find(params[:user_id])
    end

    def save
      return false unless valid?

      @rental = Rentals::Rental.create(book: @book, user: @user)
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
