module Books
  class Lookup
    def initialize(searcher)
      @searcher = searcher
    end

    def by_isbn(isbn)
      result = @searcher.search(isbn: isbn).first

      if result&.isbn == isbn.to_s
        book_hash(result)
      else
        {}
      end
    end

    private

    def book_hash(result)
      {
        isbn: result.isbn,
        title: result.title,
        description: result.description,
        pages: result.page_count,
        published_year: result.published_date.to_i,
        authors: result.authors_array,
        cover_image_url: result.image_link.sub('http', 'https')
      }
    end
  end
end
