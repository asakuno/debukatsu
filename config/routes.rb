# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homes#index'
  resources :users, only: %i[new create]
end
