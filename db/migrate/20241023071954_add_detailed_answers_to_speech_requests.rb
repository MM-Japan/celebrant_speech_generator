class AddDetailedAnswersToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :detailed_answers, :text
  end
end
