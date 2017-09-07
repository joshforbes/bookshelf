module Books
  class Book < ApplicationRecord
    attribute :active, :boolean, default: true

    validates :isbn, :title, :description, presence: true
    validates :published_year, length: { is: 4 }, allow_blank: true

    has_and_belongs_to_many :authors, class_name: 'Authors::Author'
    has_many :taggings, as: :taggable, class_name: 'Tags::Tagging'
    has_many :tags, through: :taggings

    def add_author(name)
      authors << Authors::Author.where(name: name).first_or_create
      self
    end

    def add_tag(name)
      tag = Tags::Tag.where(name: name).first_or_create
      tags << tag unless tags.include?(tag)
      self
    end

    def remove_tag(tag)
      tags.destroy tag
      tag.removed
      self
    end
  end
end
