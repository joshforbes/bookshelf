module Auth
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, only: [:create]

    def create
      user = Users::User.find_by_email(session_params[:email])

      if user && user.authenticate(session_params[:password])
        token = Users::Token.new(user)
        token.use
        render json: { token: token.body }, status: :ok
      else
        render status: :unauthorized
      end
    end

    def destroy
      Users::Token.new(current_user).regenerate

      head :no_content
    end

    private
    def session_params
      params.permit(:email, :password)
    end
  end
end