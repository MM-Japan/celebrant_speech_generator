class CreateSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :speech_requests do |t|
      t.string :name
      t.string :relation
      t.text :memories

      t.timestamps
    end
  end
end
