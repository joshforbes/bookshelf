module Tags
  class Tag < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :taggings, class_name: 'Tags::Tagging'
    has_many :books, through: :taggings, source: :taggable, source_type: 'Books::Book'

    def unused?
      self.taggings.empty?
    end
  end
end
