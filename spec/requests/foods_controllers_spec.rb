require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get foods_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get foods_path
      expect(response).to render_template(:index)
    end

    it 'displays correct placeholder text in the response body' do
      get foods_path
      expect(response.body).to include('<h3 class="food-page-title">Foods Page</h3>')
      expect(response.body).to include('<div class="add-food-container">')
      expect(response.body).to include('<table class="food-table">')
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_food_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get new_food_path
      expect(response).to render_template(:new)
    end

    it 'displays correct placeholder text in the response body' do
      get new_food_path
      expect(response.body).to include('<h3 class="Add-food-title">Add Food</h3>')
      expect(response.body).to include('<div class="food-form-container ff">')
      expect(response.body).to include('<form action="/foods" accept-charset="UTF-8" method="post">')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new food' do
        food_params = attributes_for(:food)
        expect do
          post foods_path, params: { food: food_params }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the index page' do
        food_params = attributes_for(:food)
        post foods_path, params: { food: food_params }
        expect(response).to redirect_to(foods_path)
      end

      it 'sets a flash message for successful creation' do
        food_params = attributes_for(:food)
        post foods_path, params: { food: food_params }
        expect(flash[:success]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @food = create(:food, user: @user)
    end

    it 'destroys the requested food' do
      expect do
        delete food_path(@food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the index page' do
      delete food_path(@food)
      expect(response).to redirect_to(foods_path)
    end

    it 'sets a flash message for successful deletion' do
      delete food_path(@food)
      expect(flash[:notice]).to be_present
    end
  end
end
