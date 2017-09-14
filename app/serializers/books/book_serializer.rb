module Books
  class BookSerializer < ActiveModel::Serializer
    attributes :id, :isbn, :title, :description, :pages,
               :published_year, :cover_image_url, :created_at, :authors, :tags

    has_one :owner, serializer: Users::OwnerSerializer

    def authors
      object.authors.map(&:name)
    end

    def tags
      object.tags.map(&:name)
    end
  end
end
