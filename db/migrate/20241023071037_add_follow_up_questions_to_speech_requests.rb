class AddFollowUpQuestionsToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :follow_up_questions, :text
  end
end
