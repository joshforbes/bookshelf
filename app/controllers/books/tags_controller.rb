module Books
  class TagsController < ApplicationController
    def create
      authorize Book
      form = TagBookForm.new(params.permit(:book_id, :name))

      if form.save
        render json: form.book, status: :created
      else
        render_validation_error form
      end
    end

    def destroy
      book = Book.find_by_id!(params[:book_id])
      authorize book
      tag = book.tags.find_by_id!(params[:id])

      book.remove_tag(tag)

      head :no_content
    end
  end
end
