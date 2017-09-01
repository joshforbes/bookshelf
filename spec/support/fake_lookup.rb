class FakeLookup
  def initialize(searcher = {})
    @searcher = searcher
  end

  def by_isbn(isbn)
    {
      isbn: isbn,
      title: 'Rspec',
      description: 'A book about Rspec',
      pages: 123,
      published_date: '2010',
      authors: ['David Chelimsky', 'Dan North'],
    }
  end
end
