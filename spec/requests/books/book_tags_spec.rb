require 'rails_helper'

RSpec.describe 'Book Tagging API', type: :request do
  describe 'POST #create' do
    context 'with valid params' do
      it 'adds a tag to a book' do
        book = create(:book)
        tag = create(:tag)

        expect {
          post book_tags_url(book), params: { name: tag.name }
        }.to change(book.tags, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the tag' do
        book = create(:book)

        post book_tags_url(book), params: { name: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
