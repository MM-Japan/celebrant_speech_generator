class AddGeneratedSpeechToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :generated_speech, :text
  end
end
