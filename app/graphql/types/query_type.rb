Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :book do
    type Types::BookType
    argument :id, !types.ID
    description 'A book'
    resolve ->(obj, args, ctx) { Books::Book.find(args[:id]) }
  end

  field :books do
    type types[Types::BookType]
    description 'All the books'
    resolve ->(obj, args, ctx) { Books::Book.all }
  end
end
