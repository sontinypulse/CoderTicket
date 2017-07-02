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
  describe 'GET #sign_in' do
    it 'returns http success' do
      get :sign_in
      expect(response).to have_http_status(:success)
    end
    it 'renders sign_in.html.erb' do
      get :sign_in
      expect(response).to render_template(:sign_in)
    end
  end

  describe 'create user' do
    it 'saves user if sign up successfully' do
      post :create, user: { first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456' }
      user = User.find_by_email('son@yahoo.com')
      expect(user).not_to eq nil
    end

    it 'redirect to root_path if sign up successfully' do
      post :create, user: { first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456' }
      expect(response).to redirect_to(root_path)
    end

    it 'raises an exception' do
      expect{ post(:create, {}) }.to raise_error ActionController::ParameterMissing
    end

    it 'renders new.html.erb if failed to sign up' do
      post :create, user: { first_name: 'son', last_name: 'dang', identification_number: '123', password: '123456' }
      expect(response).to render_template(:new)
    end

    it 'does not render new.html.erb if sign up successfully' do
      post :create, user: { first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456' }
      expect(response).not_to render_template(:new)
    end

  end

  describe 'POST #authenticate' do
    it 'returns http success' do
      post :authenticate
      expect(response).to have_http_status(:success)
    end
    it 'logins successfully' do
      user = User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      post :authenticate, params: { email: user.email, password: user.password }
      expect(response).to redirect_to(root_path)
    end
    it 'shows flash "Incorrect password, please check again"' do
      user = User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      post :authenticate, params: { email: user.email, password: 'wrongpassword' }
      expect(flash[:error]).to eq 'Incorrect password, please check again'
    end

    it 'renders users/sign_in page if incorrect password' do
      user = User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      post :authenticate, params: { email: user.email, password: 'wrongpassword' }
      expect(response).to render_template('users/sign_in')
    end
    it 'display flash "User not found"' do
      User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      post :authenticate, params: { email: 'noemail@yahoo.com', password: 'xxx' }
      expect(flash[:error]).to eq 'User is not found, create new one and enjoy'
    end
    it 'renders users/new if could not find email"' do
      User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      post :authenticate, params: { email: 'noemail@yahoo.com', password: 'xxx' }
      expect(response).to render_template('users/new')
    end
  end

  describe 'check not duplicate email' do
    it 'returns duplicate' do
      user = User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      get :check_email, params: { format: 'json', user: { email: user.email} }
      expect(response.body).to eq 'false'
    end
    it 'returns not duplicate' do
      User.create(first_name: 'son', last_name: 'dang', identification_number: '123', email: 'son@yahoo.com', password: '123456')
      get :check_email, params: { format: 'json', user: { email: 'email@yahoo.com' } }
      expect(response.body).to eq 'true'
    end
  end

  describe 'user logs out' do
    it 'destroys session for user' do
      delete :log_out
      expect(session[:user_id]).to eq nil
    end
    it 'redirects to root_path' do
      delete :log_out
      expect(response).to redirect_to(root_path)
    end
    it 'flashs "Logged Out" text' do
      delete :log_out
      expect(flash[:success]).to eq('Logged Out')
    end
  end
end
