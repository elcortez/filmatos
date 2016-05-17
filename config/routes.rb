Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  get 'test' => 'pages#home'
  root to: 'pages#home'

  resources :cameras, only: [:index, :show] do
    resources :bookings, only: [:create]
  end

  resources :users, only: [:show] do
    resources :cameras, only: [:new, :create, :edit, :update, :destroy]
  end
end

