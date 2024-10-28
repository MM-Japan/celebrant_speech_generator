class ChangeDefaultTokensInSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    change_column_default :speech_requests, :tokens, 1000
  end
end
