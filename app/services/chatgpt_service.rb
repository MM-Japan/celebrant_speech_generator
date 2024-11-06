class ChatgptService
  include HTTParty

  def initialize(speech_request)
    api_key = Rails.application.credentials.openai_api_key
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }
    @speech_request = speech_request
  end


  def call
    body = {
      model: "gpt-3.5-turbo",
      messages: [
        { role: "user", content: generate_prompt }
      ],
      max_tokens: 200,
      temperature: 0.7
    }

    response = HTTParty.post(@api_url, body: body.to_json, headers: @headers)

    if response.code != 200
      raise "OpenAI Error: #{response['error']['message']}"
    end

    response.dig("choices", 0, "message", "content").strip
  end

  def self.call(speech_request)
    new(speech_request).call
  end

  def self.generate_questions(speech_request)
    prompt = "Based on the following details, generate 5 follow-up questions that the user can answer about their #{speech_request.relation}, #{speech_request.name}.
              The questions should be asked from the perspective of someone answering about their #{speech_request.relation}, not the person directly:
              Childhood: #{speech_request.childhood_overview}.
              Work: #{speech_request.work_overview}.
              Family: #{speech_request.family_overview}.
              Hobbies: #{speech_request.hobbies_overview}.
              Travel: #{speech_request.travel_overview}.
              Use respectful and reverent language."

    response = HTTParty.post('https://api.openai.com/v1/chat/completions',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{Rails.application.credentials.openai_api_key}"
      },
      body: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 200
      }.to_json
    )

    response.dig('choices', 0, 'message', 'content')
  end

  def self.generate_questions(speech_request)
    prompt = "Based on the following details, generate 5 follow-up questions that the user can answer about their #{speech_request.relation}, #{speech_request.name}.
              The questions should be asked from the perspective of someone answering about their #{speech_request.relation}, not the person directly:
              Childhood: #{speech_request.childhood_overview}.
              Work: #{speech_request.work_overview}.
              Family: #{speech_request.family_overview}.
              Hobbies: #{speech_request.hobbies_overview}.
              Travel: #{speech_request.travel_overview}.
              Use respectful and reverent language."

    response = HTTParty.post('https://api.openai.com/v1/chat/completions',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{Rails.application.credentials.openai_api_key}"
      },
      body: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 200
      }.to_json
    )

    # Log the full API response for troubleshooting
    Rails.logger.info("OpenAI API response for questions: #{response.body}")

    response.dig('choices', 0, 'message', 'content') || "No questions generated."
  end

  def self.generate_speech(speech_request)
    # If detailed_answers is a hash, join the answers into a readable string
    if speech_request.detailed_answers.is_a?(Hash)
      detailed_answers = speech_request.detailed_answers.values.join("\n")
    else
      detailed_answers = speech_request.detailed_answers || "No additional details provided."
    end

    # Length of speech
    length_guidance = case speech_request.tokens
    when 1000
      "it should be a concise, 5-minute speech, approximately 750 words."
    when 2000
      "it should be a detailed, 10-minute speech, approximately 1500 words."
    when 3000
      "it should be an in-depth, 15-minute speech, approximately 2250 words."
    else
      "it should be a concise speech of about 750 words."  # Default guidance
    end

    # Create the prompt, including the detailed answers in plain text
    prompt = "Using the following details, create a heartfelt celebrant speech, #{length_guidance}:
              Childhood: #{speech_request.childhood_overview}
              Work: #{speech_request.work_overview}
              Family: #{speech_request.family_overview}
              Hobbies: #{speech_request.hobbies_overview}
              Travel: #{speech_request.travel_overview}.
              Here are more specific details provided by the family:
              #{detailed_answers}
              Please include all of the above information in a warm and respectful speech."

    response = HTTParty.post('https://api.openai.com/v1/chat/completions',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{Rails.application.credentials.openai_api_key}"
      },
      body: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        max_tokens: speech_request.tokens
      }.to_json
    )

    # Log the full API response for troubleshooting
    Rails.logger.info("OpenAI API response for speech: #{response.body}")

    # Extract and return the speech content or a fallback message
    speech_content = response.dig('choices', 0, 'message', 'content')&.strip
    speech_content || "No speech content generated."
  end

  private

  def generate_prompt
    "Create a heartfelt celebrant speech for #{@speech_request.name}, who was #{@speech_request.relation} to the requester. They shared these memories: #{@speech_request.memories}. Include a tone of warmth and reverence."
  end
end
