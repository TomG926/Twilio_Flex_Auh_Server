# app/controllers/api/v1/registrations_controller.rb

module Api
    module V1
      class RegistrationsController < BaseController
        # Skip authentication for registration
        skip_before_action :authenticate_request, only: [:create]
  
        def create
          user = User.new(sign_up_params)
  
          if user.save
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token, user: user }, status: :created
          else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation, :friendly_name, :role, :department)
        end
      end
    end
  end
  