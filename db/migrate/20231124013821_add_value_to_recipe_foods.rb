class AddValueToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_foods, :value, :decimal, precision: 10, scale: 2
  end
end
