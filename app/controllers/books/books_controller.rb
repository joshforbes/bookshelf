module Books
  class BooksController < ApplicationController
    def create
      authorize Book
      form = AddBookForm.new(params.permit(:isbn))

      if form.save
        render json: form.book, status: :created
      else
        render_validation_error form
      end
    end
  end
end
