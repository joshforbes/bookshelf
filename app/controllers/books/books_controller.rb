module Books
  class BooksController < ApplicationController
    skip_before_action :authenticate!, only: [:index]

    def index
      search_term = params[:search_term].blank? ? '*' : params[:search_term]

      results = Books::Search.search search_term, order: { created_at: :desc }

      pp results
      render json: results, status: :ok
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
