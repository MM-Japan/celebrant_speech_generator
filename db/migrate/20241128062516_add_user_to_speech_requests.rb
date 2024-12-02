class AddUserToSpeechRequests < ActiveRecord::Migration[7.0]
  def up
    # Step 1: Add the column allowing NULLs
    add_reference :speech_requests, :user, null: true, foreign_key: true

    # Step 2: Assign a default user to existing speech requests
    default_user = User.first || User.create!(email: 'default@example.com', password: 'password')
    SpeechRequest.reset_column_information
    SpeechRequest.update_all(user_id: default_user.id)

    # Step 3: Change the column to NOT NULL
    change_column_null :speech_requests, :user_id, false
  end

  def down
    remove_reference :speech_requests, :user
  end
end
