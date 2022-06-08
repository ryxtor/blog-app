Rails.application.routes.draw do

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new] do
      resources :comments, only: [:create]
    end
  end

  post 'users/:user_id/posts', to: 'posts#create', as: 'posts'
  # post 'users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'comments'
  post 'users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'likes'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "users#index"
end
