Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  devise_for :users
  root to: "users#index"

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
end
