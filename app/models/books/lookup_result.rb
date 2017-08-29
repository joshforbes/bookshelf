class Books::LookupResult
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

  def to_book
    { isbn: @isbn, title: @title, description: @description, pages: @pages, published_date: @published_date }
  end
end