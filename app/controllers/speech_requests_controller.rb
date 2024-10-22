class SpeechRequestsController < ApplicationController
  def new
    @speech_request = SpeechRequest.new
  end

  def create
    @speech_request = SpeechRequest.new(speech_request_params)

    if @speech_request.save
      @generated_speech = ChatgptService.call(@speech_request)
      @speech_request.update(generated_speech: @generated_speech) # Save the speech to the request if desired
      redirect_to @speech_request, notice: 'The celebrant speech has been successfully generated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @speech_request = SpeechRequest.find(params[:id])
  end

  private

  def speech_request_params
    params.require(:speech_request).permit(:name, :relation, :memories)
  end
end
