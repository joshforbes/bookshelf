module Rentals
  class RentalsController < ApplicationController
    def create
      checkout = Rentals::Checkout.new({ book_id: params[:book_id], user: current_user })

      if checkout.save
        render json: checkout.rental, status: :created
      else
        render_validation_error checkout
      end
    end
  end
end