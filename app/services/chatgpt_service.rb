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
  private

  def generate_prompt
    "Create a heartfelt celebrant speech for #{@speech_request.name}, who was #{@speech_request.relation} to the requester. They shared these memories: #{@speech_request.memories}. Include a tone of warmth and reverence."
  end
end
