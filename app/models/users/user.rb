module Users
  class User < ApplicationRecord
    MAXIMUM_RENTALS = 2

    has_secure_password

    has_many :tokens, -> { active }
    has_many :rentals, class_name: 'Rentals::Rental'
    has_many :active_rentals, -> { active }, class_name: 'Rentals::Rental'

    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 8 }, allow_nil: true
    validates :display_name, uniqueness: true, allow_nil: true

    def admin?
      is_admin
    end

    def token_matching(body)
      tokens.to_a.find { |token| token.equal_to?(body) } || NullToken.new
    end

    def can_rent?
      active_rentals.count < MAXIMUM_RENTALS
    end
  end
end
