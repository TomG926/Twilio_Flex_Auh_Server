# app/models/user.rb

class User < ApplicationRecord
  # Include default Devise modules. Adjust as needed.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :twilio_worker_sid, presence: true
  validates :friendly_name, :role, :department, presence: true

  # Callbacks
  before_validation :create_twilio_worker, on: :create

  private

  # Method to create a Twilio Worker and set the sid
  def create_twilio_worker
    # Initialize Twilio Client
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

    # Create a new Worker in the specified Workspace
    worker = client.taskrouter.workspaces(ENV['TWILIO_WORKSPACE_SID']).workers.create(
      friendly_name: friendly_name,
      attributes: {
        email: email,
        role: role,
        department: department
      }.to_json
    )

    # Assign the Twilio Worker SID to the user
    self.twilio_worker_sid = worker.sid
  rescue Twilio::REST::TwilioError => e
    # Add an error message to the user if Twilio Worker creation fails
    errors.add(:base, "Twilio Worker creation failed: #{e.message}")
    
    # Prevent the user from being saved
    throw(:abort)
  end
end
