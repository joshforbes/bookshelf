class ApplicationController < ActionController::API
  def render_validation_error(object)
    render json: { errors: object.errors }, status: :unprocessable_entity
  end
end
