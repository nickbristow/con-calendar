# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'sessions/new'

  root 'home#index'

  resources :users

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
