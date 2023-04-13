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

  namespace :mypage do
    resources :likes, only: %i[index]
    resource :calendars, only: %i[show]
  end

  resource :profile, only: %i[show edit update]
  resources :foods, only: %i[index show new create edit update destroy] do
    resources :likes, only: %i[create destroy]
  end
  resources :groups, only: %i[index new create show destroy] do
    resources :comments, only: %i[create destroy], shallow: true
  end

  namespace :api, defaults: { format: :json } do
    namespace :mine do
      resources :groups, only: %i[index]
    end
  end

  mount Shrine.presign_endpoint(:cache) => '/s3/params'
end
