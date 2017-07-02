require 'rails_helper'
RSpec.describe 'routing to /users/check_email', type: 'routing' do
  it 'routes /user/check_eail to users#check_email' do
		expect(get: users_check_email_path).to route_to(controller: 'users', action: 'check_email')
	end
end
