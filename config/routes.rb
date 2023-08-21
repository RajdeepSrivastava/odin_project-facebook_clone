Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users

  root to: "users#index"

  resources :friendships, only: [:create] do
    member do
      post :accept
    end
  end

  resources :posts, only: [:index, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

end
