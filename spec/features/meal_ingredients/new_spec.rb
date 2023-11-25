require 'rails_helper'

RSpec.feature 'Meal Ingredients - New', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:, name: 'Delicious Pasta') }
  let(:foods) { create_list(:food, 3) }

  before { login_as(user, scope: :user) }

  scenario 'User adds a new meal ingredient' do
    visit new_recipe_modify_meal_ingredient_path(recipe)

    expect(page).to have_content('Add Ingredient(s)')
    expect(page).to have_selector('h4.form-title', text: 'Add Ingredient(s)')

    within('.add-ingredient-form-container') do
      expect(page).to have_selector('input.quantity-input')

      expect(page).to have_button('Create Ingredient', disabled: false)

      if user == recipe.user
        expect(page).to have_link('Add Food', href: new_food_path)
      else
        expect(page).not_to have_link('Add Food', href: new_food_path)
      end
    end
  end
end
