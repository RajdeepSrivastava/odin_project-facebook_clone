Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users
  # resources :users, only: [:index, :show]

  root to: "users#index"
  
  resources :users, only: [:show] do
    member do
      get :profile
    end
  end

  resources :friendships, only: [:index, :create] do
    member do
      post :accept
    end
  end
  

  resources :posts, only: [:index, :create, :new] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :new] 
  
 
  end

end



