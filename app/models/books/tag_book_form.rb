module Books
  class TagBookForm
    include ActiveModel::Validations

    validates :book_id, presence: true
    validates :name, presence: true

    attr_accessor :book_id, :name, :book

    def initialize(params)
      @book_id = params[:book_id]
      @name = params[:name]
    end

    def save
      if valid?
        @book = Books::Book.find(@book_id)
        @book.add_tag(@name)
      end
    end
  end
end