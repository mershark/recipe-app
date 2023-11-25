require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user:) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: recipe.id }
      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new recipe' do
        expect do
          post :create, params: { recipe: attributes_for(:recipe) }
        end.to change(Recipe, :count).by(1)
        expect(response).to redirect_to(Recipe.last)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe' do
      delete :destroy, params: { id: recipe.id }
      expect(Recipe.exists?(recipe.id)).to be_falsey
      expect(response).to redirect_to(recipes_path)
    end
  end

  describe 'GET #public' do
    it 'returns a success response' do
      get :public
      expect(response).to be_successful
      expect(response).to render_template('public')
    end
  end

  describe 'GET #general_shopping_list' do
    it 'returns a success response' do
      get :general_shopping_list, params: { id: recipe.id }
      expect(response).to be_successful
      expect(response).to render_template('general_shopping_list')
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the recipe' do
        patch :update, params: { id: recipe.id, recipe: { name: 'Updated Recipe' } }
        expect(recipe.reload.name).to eq('Updated Recipe')
        expect(response).to redirect_to(recipe)
      end
    end
  end
end
