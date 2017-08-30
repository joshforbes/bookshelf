module Books
  class Book < ApplicationRecord
    validates :isbn, :title, :description, presence: true
  end
end
