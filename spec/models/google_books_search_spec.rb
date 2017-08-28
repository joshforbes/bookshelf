require 'rails_helper'

describe GoogleBooksSearch do
  describe 'searching by isnb' do
    let(:search_results) do
      [
        OpenStruct.new(
          isbn: 9781934356371,
          title: 'Rspec',
          description: 'A book about Rspec',
          page_count: 123,
          published_date: '2010',
          authors_array: ['David Chelimsky', 'Dan North'],
          categories: 'Computers'
        )
      ]
    end

    it 'finds a book by a valid isbn' do
      searcher = double('search')
      allow(searcher).to receive(:search) { search_results }
      google_books_search = GoogleBooksSearch.new(searcher)

      book_result = google_books_search.by_isbn(9781934356371)

      expect(book_result.exists).to be(true)
      expect(book_result.isbn).to eq(9781934356371)
      expect(book_result.title).to eq('Rspec')
      expect(book_result.description).to eq('A book about Rspec')
      expect(book_result.pages).to eq(123)
      expect(book_result.published_date).to eq('2010')
      expect(book_result.authors).to match_array(['David Chelimsky', 'Dan North'])
      expect(book_result.categories).to match_array(['Computers'])
    end

    it 'return a null book if the isbn does not match' do
      searcher = double('search')
      allow(searcher).to receive(:search) { search_results }
      google_books_search = GoogleBooksSearch.new(searcher)

      book_result = google_books_search.by_isbn(123456789)

      expect(book_result.exists).to be(false)
      expect(book_result.isbn).to be(nil)
    end
  end
end