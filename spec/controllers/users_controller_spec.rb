require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'renders new.html.erb' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'contains @user model' do
      get :new
      expect(assigns[:user]).not_to eq nil
    end
  end
end
