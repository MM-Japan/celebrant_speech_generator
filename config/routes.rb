Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "speech_requests#new"

  # Main routes for speech_requests with check_status member route
  resources :speech_requests, only: [:new, :create, :show, :edit, :update] do
    member do
      get :check_status
      post :analyze_sentiment
    end
  end
end
