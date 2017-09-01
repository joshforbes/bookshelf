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
      cover_image_url: 'https://books.google.com/books/content?id=0rxoPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'
    }
  end
end
