# app/controllers/api/v1/base_controller.rb

module Api
  module V1
    class BaseController < ApplicationController
      include Authenticable
      # Additional API-specific configurations can go here
    end
  end
end
