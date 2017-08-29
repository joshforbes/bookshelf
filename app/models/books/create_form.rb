class Books::CreateForm
  include ActiveModel::Model

  attr_accessor :isbn

  validates :isbn, presence: true

  def save
    return false unless valid?
    persist
  end

  private

  def persist
    result = Books::Lookup.new.by_isbn(isbn)
    return false unless result.exists?

    book = Books::Book.new(
      isbn: isbn,
      title: result.title,
      description: result.description,
      pages: result.pages,
      published_date: result.published_date
    )
    book.save

    true
  end
end
