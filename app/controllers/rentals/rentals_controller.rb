module Rentals
  class RentalsController < ApplicationController
    def create
      @rental = Rentals::Rental.create(rental_params)

      if @rental.save
        render json: @rental.book, status: :created
      else
        render_validation_error @rental
      end
    end

    private

    def rental_params
      params.permit(:book_id, :user_id)
    end
  end
end