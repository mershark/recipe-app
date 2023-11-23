Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  devise_for :users
  root to: "users#index"

  get '/public_recipes', to: 'recipes#public'
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes
end
