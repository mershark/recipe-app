class MealIngredientsController < ApplicationController
  def show
    recipe_food = RecipeFood.find(params[:id])
    redirect_to recipe_path(recipe_food.recipe)
  end

  def new
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    @ingredients = @user.foods&.map { |food| "#{food.name} in #{food.measurement_unit}" } || []
    @foods = Food.all
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    food = Food.find(params[:recipe_food][:food])
    quantity = params[:recipe_food][:quantity]

    recipe_food = RecipeFood.new(food:, recipe:, quantity:)
    recipe_food.calculate_value

    if recipe_food.save
      flash[:success] = 'Added successfully'
      redirect_to recipe_path(recipe), format: :turbo_stream
    else
      flash[:error] = 'Failed to add ingredient'
      render 'new'
    end
  end

  def update
    recipe_food = RecipeFood.find(params[:id])
    recipe_food.update(quantity: params[:recipe_food][:quantity])

    flash[:success] = 'Updated successfully'
    redirect_to recipe_path(recipe_food.recipe)
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])
    recipe_food.destroy

    flash[:success] = 'Ingredient removed successfully'
    redirect_to recipe_path(recipe_food.recipe)
  end
end
