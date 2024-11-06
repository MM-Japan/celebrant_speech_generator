class GenerateSpeechJob < ApplicationJob
  queue_as :default

  def perform(speech_request_id)
    # Find the speech request by its ID
    speech_request = SpeechRequest.find_by(id: speech_request_id)

    if speech_request.nil?
      Rails.logger.error "SpeechRequest with ID #{speech_request_id} not found"
      return
    end

    puts "Processing job for SpeechRequest ID: #{speech_request_id}"

    # Generate the speech
    generated_speech = ChatgptService.generate_speech(speech_request)
    puts "Generated speech content: #{generated_speech}"

    # Update the record
    speech_request.update(generated_speech: generated_speech)
    puts "Speech content updated in the database."

    # Broadcast update
    Turbo::StreamsChannel.broadcast_replace_to(
      "speech_request_#{speech_request.id}",
      target: "speech_frame_#{speech_request.id}",
      partial: "speech_requests/speech_content",
      locals: { speech_request: speech_request }
    )
    puts "Turbo Stream broadcast sent for speech_request ID: #{speech_request.id}"
  end
end
