class SpeechRequestsController < ApplicationController
  def new
    @speech_request = SpeechRequest.new
  end


  def create
    @speech_request = SpeechRequest.new(speech_request_params)

    if @speech_request.save
      follow_up_questions = ChatgptService.generate_questions(@speech_request)

      # Save the follow-up questions directly as a string
      @speech_request.update(follow_up_questions: follow_up_questions)

      # Redirect to the edit form where the follow-up questions will be answered
      redirect_to edit_speech_request_path(@speech_request), notice: 'Initial information received. Please answer the following questions for more details.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @speech_request = SpeechRequest.find(params[:id])

    # Split the follow-up questions string into an array using newlines as the delimiter
    @follow_up_questions = @speech_request.follow_up_questions.split("\n")
  end

  def show
    @speech_request = SpeechRequest.find(params[:id])

    respond_to do |format|
      format.html # Standard HTML response
      format.turbo_stream do
        # Render only if the speech is ready
        if @speech_request.generated_speech.present?
          render turbo_stream: turbo_stream.replace("speech_frame", partial: "speech_requests/speech_content", locals: { speech_request: @speech_request })
        else
          head :no_content
        end
      end
    end
  end




  def update
    @speech_request = SpeechRequest.find(params[:id])

    # Collect the detailed answers from the form
    if params[:speech_request][:detailed_answers].present?
      detailed_answers = params[:speech_request][:detailed_answers].values.join("\n")
    else
      detailed_answers = "No additional details were provided."
    end

    if @speech_request.update(detailed_answers: detailed_answers)
      # Start the background job to generate the speech
      GenerateSpeechJob.perform_later(@speech_request.id)

      # Immediately redirect to the show page
      redirect_to @speech_request, notice: 'The celebrant speech is being generated...'
    else
      puts "didnt redirect"
      render :edit, status: :unprocessable_entity
    end
  end



  def check_status
    @speech_request = SpeechRequest.find(params[:id])

    render json: { generated_speech: @speech_request.generated_speech }
  end




  def show
    @speech_request = SpeechRequest.find(params[:id])
  end



  private

  def speech_request_params
    params.require(:speech_request).permit(
      :name,
      :age,
      :relation,
      :childhood_overview,
      :work_overview,
      :family_overview,
      :hobbies_overview,
      :travel_overview,
      :tokens,  # Include tokens for speech length
      detailed_answers: {}  # Allows a hash of detailed answers
    )
  end



end
