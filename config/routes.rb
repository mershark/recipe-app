Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  devise_for :users
  root to: "users#index"

  get '/public_recipes', to: 'recipes#public'
  resources :foods, only: [:index, :new, :create, :destroy]
  
  resources :recipes do
    resources :meal_ingredients, only: [:new, :create, :destroy, :edit, :update], as: :modify_meal_ingredient
    resources :recipe_foods, only: [:create, :destroy, :update]
    member do
      match 'general_shopping_list', to: 'recipes#general_shopping_list', via: [:get, :post]
    end
  end  
end
