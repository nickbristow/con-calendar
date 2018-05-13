# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'sessions/new'

  root 'home#index'

  get 'events/my_calendar', to: 'events#my_events'

  resources :users, only: %i[index update show]
  resources :events
  resources :appointments

  match "*path" => redirect("/"), via: [:get]

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
