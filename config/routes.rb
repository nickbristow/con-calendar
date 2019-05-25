# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'sessions/new'

  root 'home#index'

  get 'events/my_calendar', to: 'events#my_events'
  get 'email_calendar/:id', to: 'email_calendar#email_to', as: :email_to
  post 'email_calendar', to: 'email_calendar#email_all', as: :email_all
  get 'email_calendar', to: 'email_calendar#index', as: :email_calendar

  resources :users, only: %i[index update show]
  resources :events
  resources :appointments

  resources :events do
    resources :comments
  end

  match '*path' => redirect('/'), via: [:get]

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
