module Books
  class Lookup
    def initialize(searcher)
      @searcher = searcher
    end

    def by_isbn(isbn)
      book = @searcher.search(isbn: isbn).first

      if book.isbn == isbn.to_s
        {
          isbn: book.isbn,
          title: book.title,
          description: book.description,
          pages: book.page_count,
          published_year: book.published_date.to_i,
          authors: book.authors_array,
          cover_image_url: to_https(book.image_link)
        }
      else
        {}
      end
    end

    private

    def to_https(url)
      uri = URI.parse(url)
      uri.scheme = 'https'
      uri.to_s
    end
  end
end
