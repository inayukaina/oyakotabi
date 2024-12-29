Rails.application.routes.draw do
  get 'tops/index'
  get 'child_packing_items/index'
  devise_for :users
  root to: 'tops#index'

  resources :trips do
    resources :child_packing_items, except: [:show, :new] do
      collection do
        patch :complete
      end
    end
  end

end
