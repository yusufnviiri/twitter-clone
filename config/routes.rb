Rails.application.routes.draw do
  devise_for :views
  devise_for :users
  get 'tweets/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
resources :tweets
  # Defines the root path route ("/")
  root "tweets#index"
end
