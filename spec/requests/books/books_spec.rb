require 'rails_helper'

RSpec.describe 'Books API', type: :request, search: true do
  describe 'GET #index' do
    it 'returns books when no search term is specified' do
      book = create(:book, title: 'example')
      SearchHelpers.reindex_search(Books::Search)

      get books_url, params: {  }
      puts json_response

      book_id = json_response
                  .fetch(:book)
                  .fetch(:id)
                  .to_i

      expect(book_id).to eq(book.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    before :each do
      stub_const('Books::Lookup', FakeLookup)
    end

    let(:valid_attributes) { { isbn: '9781934356371' } }

    context 'with valid params' do
      it 'creates a new Book' do
        post books_url, params: valid_attributes, headers: acting_as(create(:user, :admin))

        expect(Books::Book.count).to eq(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new book' do
        post books_url, params: { isbn: nil }, headers: acting_as(create(:user, :admin))

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
