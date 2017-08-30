module Books
  class BooksController < ApplicationController
    def create
      book_params = Books::Lookup.new(GoogleBooks).by_isbn(params[:isbn])
      @book = Books::CreateForm.new(book_params)

      if @book.save
        render json: @book, status: :created
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end
  end
end
