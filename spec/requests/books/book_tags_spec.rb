require 'rails_helper'

RSpec.describe 'Book Tagging API', type: :request do
  describe 'POST #create' do
    context 'with valid params' do
      it 'adds a tag to a book' do
        book = create(:book)
        tag = create(:tag)

        post book_tags_url(book),
             params: { name: tag.name },
             headers: acting_as(create(:user, :admin))

        expect(book.tags.count).to eq(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the tag' do
        book = create(:book)

        post book_tags_url(book),
             params: { name: nil },
             headers: acting_as(create(:user, :admin))

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a tag from a book' do
      book = create(:book)
      tag = create(:tag)
      book.tags << tag

      delete book_tag_url(book, tag), headers: acting_as(create(:user, :admin))

      expect(book.tags.count).to eq(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
