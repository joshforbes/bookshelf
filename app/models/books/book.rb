module Books
  class Book < ApplicationRecord
    validates :isbn, :title, :description, presence: true

    has_and_belongs_to_many :authors, class_name: 'Authors::Author'
  end
end
