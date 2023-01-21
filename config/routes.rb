Rails.application.routes.draw do
  devise_for :views
  # Redirests signing out users back to sign-in
get "users", to: "devise/sessions#new"
  devise_for :users
  get 'tweets/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
resources :tweets
  # Defines the root path route ("/")
  root "tweets#index"
end
