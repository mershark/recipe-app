class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.user == current_user
      @recipe.destroy
      redirect_to recipes_path, notice: 'Successfully deleted.'
    else
      redirect_to recipes_path, alert: 'Cannot delete'
    end
  end

  def public
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    render 'public'
  end

  def general_shopping_list
    @user = current_user
    @recipe = Recipe.includes(:recipe_foods).find_by(id: params[:id])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
    @needed_items = []
    @recipe_foods.each do |recipe_food|
      existed_food = @user.foods.find_by(name: recipe_food.food.name)
      if existed_food.nil?
        @needed_items << [recipe_food.food.name, recipe_food.quantity, recipe_food.food.price,
                          recipe_food.food.measurement_unit]
      else
        difference_quantity = recipe_food.quantity - existed_food.quantity
        if difference_quantity.positive?
          @needed_items << [recipe_food.food.name, difference_quantity, existed_food.price,
                            existed_food.measurement_unit]
        end
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Successfully updated.'
    else
      render :show
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
