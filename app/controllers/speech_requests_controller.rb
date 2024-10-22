class SpeechRequestsController < ApplicationController
  def new
    @speech_request = SpeechRequest.new
  end

  def create
    @speech_request = SpeechRequest.new(speech_request_params)

    if @speech_request.save
      @generated_speech = ChatgptService.call(@speech_request)
      @speech_request.update(generated_speech: @generated_speech) # Save the speech to the request if desired
      render json: { speech: @generated_speech }, status: :ok
    else
      render json: { error: @speech_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @speech_request = SpeechRequest.find(params[:id])
    @generated_speech = generate_speech(@speech_request)
  end

  private

  def speech_request_params
    params.require(:speech_request).permit(:name, :relation, :memories)
  end
end
