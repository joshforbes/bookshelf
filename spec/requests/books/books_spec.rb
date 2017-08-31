require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST #create' do
    before :each do
      stub_const('Books::Lookup', FakeLookup)
    end

    let(:valid_attributes) { { isbn: '9781934356371' } }

    context 'with valid params' do
      it 'creates a new Book' do
        expect {
          post books_url, params: valid_attributes
        }.to change(Books::Book, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new book' do
        post books_url, params: { isbn: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
