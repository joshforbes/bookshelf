class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { errors: e.message }, status: :not_found
  end

  def render_validation_error(object)
    render json: { errors: object.errors }, status: :unprocessable_entity
  end
end
