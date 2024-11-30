# config/routes.rb

Rails.application.routes.draw do
  # Public routes
  root to: 'home#index'

  # API namespace
  namespace :api do
    namespace :v1 do
      # Custom Devise routes using devise_scope
      devise_scope :user do
        post 'register', to: 'registrations#create'
        post 'login', to: 'sessions#create'
      end

      # Protected API routes
      get 'profile', to: 'profiles#show'
      get 'voicemails', to: 'voicemails#index'
      # Add other protected API routes here
    end
  end
end
