module Books
  class BooksController < ApplicationController
    skip_before_action :authenticate!, only: [:index]

    def index
      search_term = params[:search_term].blank? ? '*' : params[:search_term]

      results = Books::Book.search search_term, order: { created_at: :desc }

      render json: results.to_a, status: :ok
    end

    def create
      authorize Books::Book
      form = Books::AddBookForm.new(params.permit(:isbn))

      if form.save
        render json: form.book, status: :created
      else
        render_validation_error form
      end
    end
  end
end
