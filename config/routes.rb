Rails.application.routes.draw do
  get 'likes/index'
  get 'comments/index'
  devise_for :views
  # Redirests signing out users back to sign-in
get "users", to: "devise/sessions#new"
  devise_for :users
  get 'tweets/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
resources :tweets do
  member do
    post :retweet
  end
  resources :likes ,module: :tweets, only: :create 

  resources :comments do
    resources :likes ,module: :comments, only: :create 
   
  end
end
  # Defines the root path route ("/")
  root "tweets#index"
end
