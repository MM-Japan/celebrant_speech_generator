Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'speech_requests/new'
  get 'speech_requests/create'
  get 'speech_requests/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :speech_requests do
    member do
      get :check_status
    end
  end


  resources :speech_requests, only: [:new, :create, :show, :edit, :update]
  root "speech_requests#new"


end
