Rails.application.routes.draw do
  get 'child_packing_items/index'
  devise_for :users
  root to: 'trips#index'

  resources :trips do
    resources :child_packing_items, except: [:show, :new] do
      collection do
        post :complete
      end
    end
  end

end
