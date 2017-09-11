module Rentals
  class Rental < ApplicationRecord
    belongs_to :user, class_name: 'Users::User'
    belongs_to :book, class_name: 'Books::Book'

    scope :active, -> { where returned_at: nil }

    validates :user, :book, presence: true

    after_initialize :default_values

    private

    def default_values
      self.rented_at ||= Date.current
    end
  end
end
