class SpeechRequest < ApplicationRecord
  validates :name, :relation, :childhood_overview, :work_overview, :family_overview, :hobbies_overview, :travel_overview, presence: true
  validates :tokens, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def analyze_sentiment
    # Concatenate text fields to be analyzed
    full_text = [
      childhood_overview,
      work_overview,
      family_overview,
      hobbies_overview,
      travel_overview,
      detailed_answers,
    ].join(" ")

    # Initialize analyzer with concatenated text
    analyzer = SentimentAnalyzer.new(full_text)
    result = analyzer.analyze

    { sentiment: result[:sentiment], score: result[:score] }
  end
end
