# app/services/json_web_token.rb

require 'jwt'

class JsonWebToken
  # Fetch the secret key from environment variables
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  # Encode a payload into a JWT token
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decode a JWT token into a payload
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new(decoded.first)
  end
end
