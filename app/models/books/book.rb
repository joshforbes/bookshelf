module Books
  class Book < ApplicationRecord
    validates :isbn, :title, :description, presence: true

    has_and_belongs_to_many :authors, class_name: 'Authors::Author'

    def add_author(name)
      self.authors << Authors::Author.find_or_create_by(name: name)
      self
    end
  end
end
