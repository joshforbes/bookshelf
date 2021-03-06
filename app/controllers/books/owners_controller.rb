module Books
  class OwnersController < ApplicationController
    def create
      authorize Book
      book = Book.find(params[:book_id])
      user = Users::User.find(params[:owner_id])

      book = book.owned_by(user)

      render json: book, status: :created
    end

    def destroy
      authorize Book
      book = Book.find(params[:book_id])

      book.remove_owner

      head :no_content
    end
  end
end
