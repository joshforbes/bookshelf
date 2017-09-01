module Books
  class BooksController < ApplicationController
    def create
      @book_form = Books::AddBookForm.new(params.permit(:isbn))

      if @book_form.save
        render json: @book_form.book, status: :created
      else
        render json: { errors: @book_form.errors }, status: :unprocessable_entity
      end
    end
  end
end
