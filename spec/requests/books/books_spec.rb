require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'POST #create' do
    before :each do
      stub_const('Books::Lookup', FakeLookup)
    end

    let(:valid_attributes) { { isbn: '9781934356371' } }

    context 'with valid params' do
      it 'creates a new Book' do
        post books_url, params: valid_attributes, headers: acting_as(create(:user))

        expect(Books::Book.count).to eq(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new book' do
        post books_url, params: { isbn: nil }, headers: acting_as(create(:user))

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
