require 'rails_helper'
RSpec.describe 'routing to users/sign_in', type: 'routing' do
  it 'routes users/sign_in to users#sign_in' do
		expect(get: users_sign_in_path).to route_to(controller: 'users', action: 'sign_in')
	end
end
