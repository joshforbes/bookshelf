module Authors
  class Author < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_and_belongs_to_many :books, class_name: 'Books::Book'
  end
end
