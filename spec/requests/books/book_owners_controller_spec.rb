require 'rails_helper'

RSpec.describe 'Book Owners API', type: :request do
  describe 'POST #create' do
    context 'with valid params' do
      it 'adds a owner to a book' do
        book = create(:book)
        owner = create(:user)

        post book_owners_url(book), params: { owner_id: owner.id }, headers: acting_as(create(:user, :admin))

        expect(book.reload.owner_id).to eq(owner.id)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a owner from a book' do
      book = create(:book, :with_owner)

      delete book_owner_url(book), headers: acting_as(create(:user, :admin))

      expect(book.reload.owner_id).to be(nil)
      expect(response).to have_http_status(:no_content)
    end
  end
end
