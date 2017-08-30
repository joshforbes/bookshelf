module Books
  class CreateForm
    include ActiveModel::Model

    attr_accessor :isbn, :title, :description, :pages, :published_date, :authors

    validates :isbn, :title, :description, :authors, presence: true

    def save
      return false unless valid?
      persist!
    end

    private

    def persist!
      book = Books::Book.create!(book_params)
      authors.each { |author_name| book.add_author(author_name) }
      book
    end

    def book_params
      { isbn: isbn, title: title, description: description, pages: pages, published_date: published_date }
    end
  end
end
