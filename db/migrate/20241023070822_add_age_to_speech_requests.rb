class AddAgeToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :age, :integer
  end
end
