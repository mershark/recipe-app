require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'follows the redirection and returns a success response' do
      get root_path
      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('devise/sessions/new')
    end
  end
end
