module Rentals
  class RentalsController < ApplicationController
    def create
      checkout = Rentals::Checkout.new(rental_params.merge(user: current_user))

      if checkout.save
        render json: checkout.rental, status: :created
      else
        render_validation_error checkout
      end
    end

    private

    def rental_params
      params.permit(:book_id)
    end
  end
end