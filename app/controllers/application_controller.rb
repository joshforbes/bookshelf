class ApplicationController < ActionController::API
  include WardenHelper
  include Pundit

  rescue_from ActiveRecord::RecordNotFound do
    render json: { errors: 'not found' }, status: :not_found
  end

  rescue_from Pundit::NotAuthorizedError do
    render json: { errors: 'unauthorized' }, status: :forbidden
  end

  def render_validation_error(object)
    render json: { errors: object.errors }, status: :unprocessable_entity
  end
end
