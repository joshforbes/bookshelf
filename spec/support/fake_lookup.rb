class FakeLookup
  def initialize(searcher = nil)
    @searcher = searcher
  end

  def by_isbn(isbn)
    Books::LookupResult.new(OpenStruct.new(
      isbn: isbn,
      title: 'Rspec',
      description: 'A book about Rspec',
      pages: 123,
      published_date: '2010',
      authors_array: ['David Chelimsky', 'Dan North'],
      categories: 'Computers'
    ))
  end
end
