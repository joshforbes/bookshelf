Types::BookType = GraphQL::ObjectType.define do
  name 'Book'
  field :title, !types.String
  field :isbn, !types.String
  field :description, !types.String
  field :pages, !types.Int
  field :published_year, !types.Int
  field :cover_image_url, !types.String
  field :authors, types[Types::AuthorType]
  field :tags, types[Types::TagType]
end
