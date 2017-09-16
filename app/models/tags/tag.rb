module Tags
  class Tag < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :taggings
    has_many :books, through: :taggings, source: :taggable, source_type: 'Books::Book'

    def removed
      destroy if unused?
    end

    private

    def unused?
      taggings.empty?
    end
  end
end
