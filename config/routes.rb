Rails.application.routes.draw do
  devise_for :users
  root to: 'trips#index'

  resources :trips, only: [:new, :create, :index, :show, :edit, :update]
end
