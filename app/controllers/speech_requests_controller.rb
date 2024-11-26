class SpeechRequestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @speech_request = SpeechRequest.new
  end

  def create
    @speech_request = SpeechRequest.new(speech_request_params)

    if @speech_request.save
      Rails.logger.info("SpeechRequest created with ID: #{@speech_request.id}")

      # Call the ChatgptService to generate follow-up questions
      follow_up_questions = ChatgptService.generate_questions(@speech_request)
      Rails.logger.info("Follow-up questions generated: #{follow_up_questions}")

      # Save the follow-up questions directly as a string
      @speech_request.update(follow_up_questions: follow_up_questions)
      redirect_to edit_speech_request_path(@speech_request), notice: 'Initial information received. Please answer the following questions for more details.'
    else
      Rails.logger.error("Failed to save SpeechRequest: #{@speech_request.errors.full_messages}")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @speech_request = SpeechRequest.find(params[:id])

    # Log to confirm the follow-up questions are being retrieved
    Rails.logger.info("Editing SpeechRequest ID: #{@speech_request.id} with follow-up questions: #{@speech_request.follow_up_questions}")

    # Split the follow-up questions string into an array using newlines as the delimiter
    @follow_up_questions = @speech_request.follow_up_questions&.split("\n") || []
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
      Rails.logger.info("SpeechRequest ID: #{@speech_request.id} updated with detailed answers.")

      # Start the background job to generate the speech
      GenerateSpeechJob.perform_later(@speech_request.id)
      Rails.logger.info("GenerateSpeechJob triggered for SpeechRequest ID: #{@speech_request.id}")

      redirect_to @speech_request, notice: 'The celebrant speech is being generated...'
    else
      Rails.logger.error("Failed to update SpeechRequest: #{@speech_request.errors.full_messages}")
      render :edit, status: :unprocessable_entity
    end
  end

  def check_status
    @speech_request = SpeechRequest.find(params[:id])
    Rails.logger.info("Checking status of SpeechRequest ID: #{@speech_request.id}")
    render json: { generated_speech: @speech_request.generated_speech }
  end

  def show
    @speech_request = SpeechRequest.find(params[:id])
    @sentiment = @speech_request.analyze_sentiment
    Rails.logger.info("Showing SpeechRequest ID: #{@speech_request.id} with sentiment analysis.")
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
      :tokens,

      detailed_answers: {}

    )
  end
end
