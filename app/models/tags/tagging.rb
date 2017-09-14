module Tags
  class Tagging < ApplicationRecord
    belongs_to :tag, class_name: 'Tags::Tag'
    belongs_to :taggable, polymorphic: true
  end
end
