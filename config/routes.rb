Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :books do
    resources :branches, only: [] do
        resources :copies, only: [:create]
    end
  end

  resources :copies, only: [:destroy] do
    member do
      post :restore
    end
  end

  resources :checkouts, only: [:index, :create, :destroy] do
    collection do
      get :admin_index
    end
  end

end
