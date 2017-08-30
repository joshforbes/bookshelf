class Books::Lookup
  def initialize(searcher)
    @searcher = searcher
  end

  def by_isbn(isbn)
    book = @searcher.search(isbn: isbn).first

    if book.isbn == isbn.to_s
      Result.new(book)
    else
      NullResult.new
    end
  end

  private

  class Result
    attr_reader :isbn, :title, :description, :pages, :published_date, :authors, :categories

    def initialize(book)
      @isbn = book.isbn
      @title = book.title
      @description = book.description
      @pages = book.page_count
      @published_date = book.published_date
      @authors = book.authors_array
      @categories = book.categories.split(/\s*,\s*/)
    end

    def exists?
      true
    end
  end

  class NullResult
    def exists?
      false
    end

    def method_missing(method, *args, &block)
      nil
    end
  end
end
