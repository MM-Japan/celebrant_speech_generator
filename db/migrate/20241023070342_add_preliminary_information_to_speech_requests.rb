class AddPreliminaryInformationToSpeechRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :speech_requests, :childhood_overview, :text
    add_column :speech_requests, :work_overview, :text
    add_column :speech_requests, :family_overview, :text
    add_column :speech_requests, :hobbies_overview, :text
    add_column :speech_requests, :travel_overview, :text
  end
end
