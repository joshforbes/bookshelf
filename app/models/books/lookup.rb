class Books::Lookup
  def initialize(searcher = GoogleBooks)
    @searcher = searcher
  end

  def by_isbn(isbn)
    book = @searcher.search(isbn: isbn).first

    if book.isbn == isbn.to_s
      Books::LookupResult.new(book)
    else
      Books::NullLookupResult.new
    end
  end
end
