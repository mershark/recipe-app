require 'rails_helper'

RSpec.feature 'Foods - Index', type: :feature do
  let(:user) { create(:user) }
  let!(:foods) { create_list(:food, 3, user:) }

  before { login_as(user, scope: :user) }

  scenario 'User views the foods index page' do
    visit foods_path

    expect(page).to have_content('Foods Page')
    expect(page).to have_selector('h3.food-page-title', text: 'Foods Page')
    expect(page).to have_link('Add Food', href: new_food_path)

    within('.food-table') do
      expect(page).to have_selector('th.food-input-title', text: 'Quantity')
      expect(page).to have_selector('th.food-input-title', text: 'Food')
      expect(page).to have_selector('th.food-input-title', text: 'Measurement unit')
      expect(page).to have_selector('th.food-input-title', text: 'Unit price')
      expect(page).to have_selector('th.food-input-title', text: 'Actions')

      foods.each do |food|
        expect(page).to have_selector('td.food-input', text: food.quantity)
        expect(page).to have_selector('td.food-input', text: food.name)
        expect(page).to have_selector('td.food-input', text: food.measurement_unit)
        expect(page).to have_selector('td.food-input', text: food.price)

        if food.user == user
          expect(page).to have_link('Delete', href: food_path(food))
        else
          expect(page).not_to have_link('Delete', href: food_path(food))
        end
      end
    end
  end
end
