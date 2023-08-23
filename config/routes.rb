Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users
  # resources :users, only: [:index, :show]

  root to: "users#index"

  resources :friendships, only: [:create] do
    member do
      post :accept
    end
  end

  resources :posts, only: [:index, :create, :new] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :new] 
  end

end




# Rails.application.routes.draw do
#   get 'comments/create'
#   get 'comments/destroy'
#   get 'likes/create'
#   get 'likes/destroy'
#   devise_for :users

#   root to: "users#index"

#   resources :friendships, only: [:create] do
#     member do
#       post :accept
#     end
#   end

#   resources :posts, only: [:index, :create, :new] do
#     resources :likes, only: [:create, :destroy]
#     resources :comments, only: [:create, :destroy, :new] 
#   end

#   resource :user, only: [] do
#     get 'edit_profile', on: :member
#     patch 'update_profile', on: :member
#   end
# end
