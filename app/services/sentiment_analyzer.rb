class SentimentAnalyzer
  def initialize(text)
    @text = text.downcase
    @positive_words = load_words('positive_words.txt')
    @negative_words = load_words('negative_words.txt')
  end

  def analyze
    positive_count = count_words(@positive_words)
    negative_count = count_words(@negative_words)

    { sentiment: calculate_sentiment(positive_count, negative_count), score: positive_count - negative_count }
  end

  private

  def load_words(filename)
    file_path = Rails.root.join('lib', filename)
    File.readlines(file_path).map(&:chomp)
  end

  def count_words(word_list)
    word_list.count { |word| @text.include?(word) }
  end

  def calculate_sentiment(positive_count, negative_count)
    if positive_count > negative_count
      'Positive'
    elsif negative_count > positive_count
      'Negative'
    else
      'Neutral'
    end
  end
end
