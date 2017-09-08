module Books
  class AddBookForm
    include ActiveModel::Validations

    validates :isbn, presence: true
    validate :has_results

    attr_accessor :isbn, :book

    def initialize(params, lookup = Books::Lookup.new(GoogleBooks))
      @isbn = params[:isbn]
      @result = lookup.by_isbn(@isbn)
    end

    def save
      if valid?
        @book = Books::Book.create!(book_params)
        authors.each { |author_name| @book.add_author(author_name) }
      end
    end

    private

    def has_results
      errors.add(:isbn, 'invalid ISBN') if @result.empty?
    end

    def book_params
      @result.slice(:isbn, :title, :description, :pages, :published_year, :cover_image_url)
    end

    def authors
      @result[:authors]
    end
  end
end
