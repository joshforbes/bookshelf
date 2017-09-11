require 'rails_helper'

RSpec.describe 'Rentals API', type: :request do
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Rental' do
        user = create(:user)
        book = create(:book)
        post rentals_url, params: { book_id: book.id }, headers: acting_as(user)

        expect(Rentals::Rental.count).to eq(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with a already rented book' do
      it 'renders a JSON response with errors' do
        book = create(:book, :with_rental)
        post rentals_url, params: { book_id: book.id }, headers: acting_as(create(:user))

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a active rental' do
      rental = create(:rental)
      user = rental.user

      delete rental_url(rental), headers: acting_as(user)

      expect(response).to have_http_status(:no_content)
      expect(rental.reload.returned_at).to eq(Date.current)
    end

    context 'with a rental that is not active' do
      it 'renders a JSON response with errors' do
        rental = create(:rental, returned_at: Date.yesterday)
        user = rental.user

        delete rental_url(rental), headers: acting_as(user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
