class Books::CreateForm
  include ActiveModel::Model

  attr_accessor :isbn

  validates :isbn, presence: true

  def save
    return false unless valid?

    result = Books::Lookup.new.by_isbn(isbn)

    return false unless result.exists?

    book = Books::Book.new(result.to_book)
    book.save

    book
  end
end
