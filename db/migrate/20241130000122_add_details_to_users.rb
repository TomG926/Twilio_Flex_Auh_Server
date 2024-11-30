class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :friendly_name, :string
    add_column :users, :role, :string
    add_column :users, :department, :string
    add_column :users, :twilio_worker_sid, :string
  end
end
