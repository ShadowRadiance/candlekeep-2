Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :books do
    resources :copies, only: [:create, :destroy] do
      member do
        post :restore
      end
    end
  end

  resources :checkouts, only: [:index, :create, :update]

end
