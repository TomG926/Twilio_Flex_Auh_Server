# app/controllers/api/v1/sessions_controller.rb

module Api
    module V1
      class SessionsController < BaseController
        # Skip authentication for login
        skip_before_action :authenticate_request, only: [:create]
  
        def create
          user = User.find_by(email: params[:email])
  
          if user&.valid_password?(params[:password])
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token, user: user }, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
      end
    end
  end
  