require 'rails_helper'

describe Books::Lookup do
  describe '#by_isbn' do
    let(:search_results) do
      [
        OpenStruct.new(
          isbn: '9781934356371',
          title: 'Rspec',
          description: 'A book about Rspec',
          page_count: 123,
          published_date: 2010,
          authors_array: ['David Chelimsky', 'Dan North'],
          image_link: 'http://www.google.com'
        )
      ]
    end

    it 'finds a book by a valid isbn' do
      searcher = double('search')
      allow(searcher).to receive(:search) { search_results }
      google_books_search = Books::Lookup.new(searcher)

      book_result = google_books_search.by_isbn('9781934356371')

      expect(book_result.any?).to be(true)
      expect(book_result[:isbn]).to eq('9781934356371')
      expect(book_result[:title]).to eq('Rspec')
      expect(book_result[:description]).to eq('A book about Rspec')
      expect(book_result[:pages]).to eq(123)
      expect(book_result[:published_year]).to eq(2010)
      expect(book_result[:authors]).to match_array(['David Chelimsky', 'Dan North'])
      expect(book_result[:cover_image_url]).to eq('https://www.google.com')
    end

    it 'return an empty hash if the isbn does not match' do
      searcher = double('search')
      allow(searcher).to receive(:search) { search_results }
      google_books_search = Books::Lookup.new(searcher)

      book_result = google_books_search.by_isbn('123456789')

      expect(book_result.empty?).to be(true)
      expect(book_result[:isbn]).to be(nil)
    end
  end
end
