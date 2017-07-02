require 'rails_helper'
RSpec.describe 'routing to /sign_up', type: 'routing' do
  it 'routes users/new to users#sign_up' do
    expect(get: new_user_path).to route_to(controller: 'users', action: 'new')
	end
  it 'routes POST /users to users#create' do
    expect(post: users_path).to route_to(controller: 'users', action: 'create')
  end
end
