# app/services/twilio_service.rb

require 'twilio-ruby'

class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @workspace_sid = ENV['TWILIO_WORKSPACE_SID']
  end

  # Fetch agent statistics from Twilio TaskRouter
  def get_agent_stats(worker_sid)
    worker = @client.taskrouter.workspaces(@workspace_sid)
                     .workers(worker_sid)
                     .fetch

    {
      friendly_name: worker.friendly_name,
      activities: worker.activities.map(&:friendly_name),
      attributes: JSON.parse(worker.attributes)
      # Add more stats as needed
    }
  end

  # Fetch voicemails (recordings) for a worker
  def list_voicemails(worker_sid)
    # Fetch recordings associated with the worker's call SIDs
    # This assumes that you have a way to associate recordings with workers
    # For example, by storing call_sid or other metadata in recording attributes

    # Placeholder implementation:
    recordings = @client.recordings.list(limit: 20)

    voicemails = recordings.map do |recording|
      {
        sid: recording.sid,
        date_created: recording.date_created,
        from: recording.call_sid, # Modify based on actual association
        duration: recording.duration,
        recording_url: recording.uri.gsub('.json', '.mp3')
      }
    end

    voicemails
  end

  # Create a new Twilio TaskRouter Worker
  def create_worker(friendly_name, role, department)
    worker = @client.taskrouter.workspaces(@workspace_sid)
                     .workers
                     .create(
                       friendly_name: friendly_name,
                       attributes: {
                         role: role,
                         department: department
                       }.to_json
                     )
    worker
  end
end
