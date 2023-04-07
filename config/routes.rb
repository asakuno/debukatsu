# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'homes#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post '/guest', to: 'guest_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :foods, only: %i[index show new create edit update destroy] do
    resources :likes, only: %i[create destroy]
    collection do
      get :likes
    end
  end
  resources :groups, only: %i[index new create show destroy] do
    resources :comments, only: %i[create destroy], shallow: true
  end
  mount Shrine.presign_endpoint(:cache) => '/s3/params'
end
