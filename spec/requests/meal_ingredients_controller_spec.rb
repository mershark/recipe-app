require 'rails_helper'

RSpec.describe MealIngredientsController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }
  let(:food) { create(:food) }

  before { sign_in user }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { recipe_id: recipe.id, recipe_food: { food: food.id, quantity: '1 cup' } } }

      it 'creates a new meal ingredient' do
        expect do
          post :create, params: valid_attributes
        end.to change(RecipeFood, :count).by(1)

        expect(response).to redirect_to(recipe_path(recipe))
        expect(flash[:success]).to eq('Added successfully')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:recipe_food) { create(:recipe_food, recipe:, food:, quantity: '1 cup') }
      let(:updated_attributes) do
        { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { food: food.id, quantity: '2 cups' } }
      end

      it 'updates the meal ingredient' do
        patch :update, params: updated_attributes
        recipe_food.reload

        expect(recipe_food.quantity).to eq(2)
        expect(response).to redirect_to(recipe_path(recipe))
        expect(flash[:success]).to eq('Updated successfully')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid parameters' do
      let!(:recipe_food) { create(:recipe_food, recipe:, food:, quantity: '1 cup') }

      it 'destroys the meal ingredient' do
        expect do
          delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
        end.to change(RecipeFood, :count).by(-1)

        expect(response).to redirect_to(recipe_path(recipe))
      end
    end
  end
end
