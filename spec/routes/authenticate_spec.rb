require 'rails_helper'
RSpec.describe 'routing authenticate', type: 'routing' do
  it 'routes users_authenticate_path to users#authenticate' do
		expect(post: users_authenticate_path).to route_to(controller: 'users', action: 'authenticate')
	end
end
