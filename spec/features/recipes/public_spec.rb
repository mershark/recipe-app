require 'rails_helper'

RSpec.feature 'Public Recipes', type: :feature do
  let(:user) { create(:user, name: 'John') }

  before { login_as(user, scope: :user) }

  scenario 'User views public recipes' do
    create(:recipe, name: 'Pasta', user:, public: true)
    create(:recipe, name: 'Salad', user:, public: true)

    visit public_recipes_path

    expect(page).to have_content('Public Recipes')

    expect(page).to have_link('Pasta', href: recipe_path(Recipe.find_by(name: 'Pasta')))
    expect(page).to have_content('By: John')
    expect(page).to have_content('Total food items:')
    expect(page).to have_content('Total price: $')
    expect(page).to have_link('Remove', visible: false)

    expect(page).to have_link('Salad', href: recipe_path(Recipe.find_by(name: 'Salad')))
    expect(page).to have_content('By: John')
    expect(page).to have_content('Total food items:')
    expect(page).to have_content('Total price: $')
    expect(page).to have_link('Remove', visible: false)
  end
end
