# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homes#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post '/guest', to: 'guest_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :foods, only: %i[index show new create]
  resources :groups, only: %i[index new create show]
end
