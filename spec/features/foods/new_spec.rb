require 'rails_helper'

RSpec.feature 'Foods - New', type: :feature do
  let(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  scenario 'User visits the new food page' do
    visit new_food_path

    expect(page).to have_content('Add Food')
    expect(page).to have_selector('h3.Add-food-title', text: 'Add Food')

    within('.food-form-container') do
      expect(page).to have_selector('form[action="/foods"]')

      expect(page).to have_selector('input[name="food[name]"]')

      expect(page).to have_selector('select[name="food[measurement_unit]"]')
      expect(page).to have_selector('select[name="food[measurement_unit]"] option', count: 5)

      expect(page).to have_selector('input[name="food[price]"]')

      expect(page).to have_selector('input[name="food[quantity]"]')

      expect(page).to have_button('Add Food', disabled: false)
    end
  end
end
