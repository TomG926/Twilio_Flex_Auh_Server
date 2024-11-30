# app/controllers/concerns/authenticable.rb

module Authenticable
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_request
    end
  
    private
  
    def authenticate_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
  
      if token.present?
        begin
          decoded = JsonWebToken.decode(token)
          @current_user = User.find(decoded['user_id'])
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'User not found' }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { error: 'Invalid token' }, status: :unauthorized
        end
      else
        render json: { error: 'Missing token' }, status: :unauthorized
      end
    end
  end
  