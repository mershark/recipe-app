require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  scenario 'User creates a new recipe' do
    visit new_recipe_path

    expect(page).to have_content('Create New Recipe')

    fill_in 'recipe_name', with: 'Delicious Pasta'

    sleep 5

    fill_in 'recipe_preparation_time', with: 3
    fill_in 'recipe_cooking_time', with: 6
    fill_in 'recipe_description', with: 'A tasty pasta recipe.'
    check 'recipe_public'

    expect(page).to have_field('recipe_name')
    expect(page).to have_field('recipe_preparation_time')
    expect(page).to have_field('recipe_cooking_time')
    expect(page).to have_field('recipe_description')
    expect(page).to have_field('recipe_public')

    expect(page).to have_button('Create Recipe')

    expect(page).to have_link('Home', href: '/')
  end
end
