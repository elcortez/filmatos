Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  get 'test' => 'pages#home'
  root to: 'pages#home'

  resources :cameras, only: [:index, :show] do
    resources :bookings, only: [:create]
    resources :reviews, only: [:create]
  end

  get '/bookings/:id/accepted/' => 'bookings#mark_as_accepted', as: :camera_booking_accepted
  get '/bookings/:id/declined/' => 'bookings#mark_as_declined', as: :camera_booking_declined

  resources :users, only: [:show] do
    resources :cameras, only: [:new, :create, :edit, :update, :destroy]
  end
end

