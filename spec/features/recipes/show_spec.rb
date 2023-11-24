require 'rails_helper'

RSpec.feature 'Show Recipe', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:, name: 'Delicious Pasta', public: true) }

  before { login_as(user, scope: :user) }

  scenario 'User views a recipe' do
    visit recipe_path(recipe)

    expect(page).to have_content('Delicious Pasta')
    expect(page).to have_content('Preparation Time:')
    expect(page).to have_content('Cooking Time:')
    expect(page).to have_content('Description:')
    expect(page).to have_content('Generate Shopping List')
    expect(page).to have_content('Add Ingredients')

    within('#recipe-display-container') do
      expect(page).to have_selector('form#recipe-form')
      expect(page).to have_selector('input#public-checkbox')
      expect(page).to have_selector('input#public-status-submit')
    end

    recipe.update(public: true)
    visit recipe_path(recipe)

    within('#recipe-display-container') do
      expect(page).to have_selector('form#recipe-form')
      expect(page).to have_selector('input#public-checkbox')
      expect(page).to have_selector('input#public-status-submit')
    end
  end
end
