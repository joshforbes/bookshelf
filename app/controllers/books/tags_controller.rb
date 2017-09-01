module Books
  class TagsController < ApplicationController
    def create
      @form = Books::TagBookForm.new(params.permit(:book_id, :name))

      if @form.save
        render json: @form.book, status: :created
      else
        render_validation_error @form
      end
    end
  end
end
