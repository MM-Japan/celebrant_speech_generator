Rails.application.routes.draw do
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Replace 'admin' and 'password' with your own credentials.
    ActiveSupport::SecurityUtils.secure_compare(username, ENV["max"]) &
    ActiveSupport::SecurityUtils.secure_compare(password, ENV["m0n0p0ly"])
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  # In config/routes.rb
  root "pages#home" # If using PagesController


  # Main routes for speech_requests with check_status member route
  resources :speech_requests, only: [:new, :create, :show, :edit, :update] do
    member do
      get :check_status
      post :analyze_sentiment
    end
  end
end
