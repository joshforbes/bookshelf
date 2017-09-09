class ApplicationController < ActionController::API
  include WardenHelper

  rescue_from ActiveRecord::RecordNotFound do
    render json: { errors: 'not found' }, status: :not_found
  end

  def render_validation_error(object)
    render json: { errors: object.errors }, status: :unprocessable_entity
  end
end
