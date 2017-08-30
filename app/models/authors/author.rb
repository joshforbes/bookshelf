module Authors
  class Author < ApplicationRecord
    validates :name, presence: true
  end
end
