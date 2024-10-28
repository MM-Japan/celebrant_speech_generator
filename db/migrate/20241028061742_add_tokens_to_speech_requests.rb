class AddTokensToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :tokens, :integer
  end
end
