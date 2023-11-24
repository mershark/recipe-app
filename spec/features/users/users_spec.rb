require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'User visits the index page' do
    user = create(:user)

    login_as(user, scope: :user)

    visit root_path
    expect(page).to have_text('Welcome to the Users#index view!')
  end
end
