# app/controllers/home_controller.rb

class HomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the Twilio Flex Auth Server API' }, status: :ok
  end
end
