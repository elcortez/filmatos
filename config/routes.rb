Rails.application.routes.draw do
  devise_for :users

  get 'test' => 'pages#home'
  root to: 'pages#home'

  resources :cameras do
    resources :bookings, only: [:create]
  end

  resources :users, only: [:show]
end

