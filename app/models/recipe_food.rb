class RecipeFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id'
  belongs_to :recipe, foreign_key: 'recipe_id'

  before_save :calculate_value

  def calculate_value
    self.value = quantity * food.price
  end
end
