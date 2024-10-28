class SpeechRequest < ApplicationRecord
  validates :name, :relation, :childhood_overview, :work_overview, :family_overview, :hobbies_overview, :travel_overview, presence: true
end

