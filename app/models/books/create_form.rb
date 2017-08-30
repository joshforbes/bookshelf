class Books::CreateForm
  include ActiveModel::Model

  attr_accessor :isbn, :title, :description, :pages, :published_date, :authors

  validates :isbn, :title, :description, presence: true

  def save
    return false unless valid?
    persist!
  end

  private

  def persist!
    Books::Book.create!(
      isbn: isbn,
      title: title,
      description: description,
      pages: pages,
      published_date: published_date
    )
  end
end
