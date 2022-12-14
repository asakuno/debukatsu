# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  root to: 'homes#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post '/guest', to: 'guest_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :foods, only: %i[index show new create destroy]
  resources :groups, only: %i[index new create show]
end
