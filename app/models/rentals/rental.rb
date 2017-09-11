module Rentals
  class Rental < ApplicationRecord
    DURATION_IN_DAYS = 14.days

    belongs_to :user, class_name: 'Users::User'
    belongs_to :book, class_name: 'Books::Book'

    scope :active, -> { where returned_at: nil }
    scope :overdue, -> { active.where('rented_at < ?', DURATION_IN_DAYS.ago) }

    validates :user, :book, presence: true

    after_initialize :default_values

    def check_in
      self.returned_at ||= Date.current
      save
      self
    end

    private

    def default_values
      self.rented_at ||= Date.current
    end
  end
end
