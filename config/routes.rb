Rails.application.routes.draw do

  devise_for :users

  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    secure_username = ENV["SIDEKIQ_USERNAME"].to_s
    secure_password = ENV["SIDEKIQ_PASSWORD"].to_s
    ActiveSupport::SecurityUtils.secure_compare(username, secure_username) &
    ActiveSupport::SecurityUtils.secure_compare(password, secure_password)
  end if Rails.env.production?
 # scope '/celebrant' do
    mount Sidekiq::Web => '/sidekiq'


    # Health check
    get "up" => "rails/health#show", as: :rails_health_check

    # Root path
    # In config/routes.rb
    root "pages#home" # If using PagesController


    # Main routes for speech_requests with check_status member route
    resources :speech_requests, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      member do
        get :check_status
        post :analyze_sentiment
      end
    end
  #end
end
