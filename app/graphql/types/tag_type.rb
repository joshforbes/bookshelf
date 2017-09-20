Types::TagType = GraphQL::ObjectType.define do
  name 'Tag'
  field :name, !types.String
  field :books, types[Types::BookType]
end
