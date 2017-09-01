module Books
  class CreateForm
    include ActiveModel::Validations

    validates :isbn, presence: true
    validate :lookup_succeeded

    attr_accessor :isbn, :book

    def initialize(params, lookup = Books::Lookup.new(GoogleBooks))
      @isbn = params[:isbn]
      @lookup = lookup
      @result = {}
    end

    def save
      @result = @lookup.by_isbn(@isbn)

      if valid?
        @book = Books::Book.create!(book_params)
        authors.each { |author_name| @book.add_author(author_name) }
      end
    end

    private

    def lookup_succeeded
      errors.add(:isbn, 'invalid ISBN') if @result.empty?
    end

    def book_params
      @result.slice(:isbn, :title, :description, :pages, :published_date)
    end

    def authors
      @result[:authors]
    end
  end
end
