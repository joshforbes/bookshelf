class Books::Book < ApplicationRecord
  validates :isbn, :title, :description, presence: true
end
