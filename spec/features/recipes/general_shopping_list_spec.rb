require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }
  let(:food) { create(:food) }

  before { login_as(user, scope: :user) }

  scenario 'User views the general shopping list page' do
    recipe_food = create(:recipe_food, recipe:, food:, quantity: '2 kg')

    visit general_shopping_list_recipe_path(recipe)

    expect(page).to have_content('Shopping list')
    expect(find('p', text: 'Amount of food items to buy: 1')).to be_visible

    expect(page).to have_content(food.name)
    expect(page).to have_content('2 kg')
    expect(page).to have_content(number_to_currency(recipe_food.calculate_value, unit: '$'))
  end
end
