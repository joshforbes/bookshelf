module Rentals
  class Rental < ApplicationRecord
    belongs_to :user, class_name: 'Users::User'
    belongs_to :book, class_name: 'Books::Book'

    scope :active, -> { where returned_at: nil }

    validates :user, :book, presence: true
  end
end
