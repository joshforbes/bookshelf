class Book < ApplicationRecord
  validates :isbn, :title, :description, presence: true
end
