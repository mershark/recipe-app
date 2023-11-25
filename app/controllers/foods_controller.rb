class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      flash[:success] = 'Food added successfully.'
      redirect_to foods_path
    else
      flash[:error] = 'Failed to add food.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      flash[:notice] = 'Food deleted successfully.'
    else
      flash[:alert] = 'Failed to delete food.'
    end

    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
