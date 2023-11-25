require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  scenario 'User views the recipe index page' do
    recipe1 = create(:recipe, name: 'Recipe 1', description: 'Description for Recipe 1', user:)
    recipe2 = create(:recipe, name: 'Recipe 2', description: 'Description for Recipe 2', user:)

    visit recipes_path

    expect(page).to have_content('All Recipes')

    within('.recipe-container', text: 'Recipe 1') do
      expect(page).to have_link('Recipe 1', href: recipe_path(recipe1))
      expect(page).to have_content('Description for Recipe 1')
      expect(page).to have_link('Remove', href: recipe_path(recipe1))
    end

    within('.recipe-container', text: 'Recipe 2') do
      expect(page).to have_link('Recipe 2', href: recipe_path(recipe2))
      expect(page).to have_content('Description for Recipe 2')
      expect(page).to have_link('Remove', href: recipe_path(recipe2))
    end
  end
end
