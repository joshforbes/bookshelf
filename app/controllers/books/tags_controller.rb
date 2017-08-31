module Books
  class TagsController < ApplicationController
    def create
      @book = Books::Book.find(params[:book_id])
      @book.add_tag(params[:name])

      render json: @book, status: :created
    end
  end
end
