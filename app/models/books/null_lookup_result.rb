class Books::NullLookupResult
  def exists?
    false
  end

  def to_book
    { isbn: nil, title: nil, description: nil, pages: nil, published_date: nil }
  end

  def method_missing(method, *args, &block)
    nil
  end
end