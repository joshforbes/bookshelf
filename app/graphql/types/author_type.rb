Types::AuthorType = GraphQL::ObjectType.define do
  name 'Author'
  field :name, !types.String
  field :books, types[Types::BookType]
end
