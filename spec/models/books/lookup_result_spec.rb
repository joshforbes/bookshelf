require 'rails_helper'

RSpec.describe Books::LookupResult do
  describe '#exists?' do
    it 'exists' do
      book_result = Books::LookupResult.new(double(:book).as_null_object)

      expect(book_result.exists?).to be(true)
    end
  end

  describe '#to_book' do
    it 'returns an book hash with expected values' do
      book = double
      allow(book).to receive_messages(
        isbn: '123',
        title: 'Test book',
        description: 'A test book',
        page_count: 123,
        published_date: '2017',
        authors_array: ['Test author'],
        categories: ['Test']
      )
      book_result = Books::LookupResult.new(book)

      book_hash = book_result.to_book

      expect(book_hash).to eq({
        isbn: '123',
        title: 'Test book',
        description: 'A test book',
        pages: 123,
        published_date: '2017'
      })
    end
  end
end
