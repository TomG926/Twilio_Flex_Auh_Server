# app/controllers/api/v1/profiles_controller.rb

module Api
    module V1
      class ProfilesController < BaseController
        def show
          render json: { user: @current_user }, status: :ok
        end
      end
    end
  end
  