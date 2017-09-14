module Books
  class BookSerializer < ActiveModel::Serializer
    attributes :id, :owner_id, :isbn, :title, :description, :pages,
               :published_year, :cover_image_url, :created_at, :authors, :tags

    def authors
      object.authors.map(&:name)
    end

    def tags
      object.tags.map(&:name)
    end
  end
end
