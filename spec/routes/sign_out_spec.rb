require 'rails_helper'
RSpec.describe 'routing to /log_out', type: 'routing' do
  it 'routes log_out to users#log_out' do
		expect(delete: log_out_path).to route_to(controller: 'users', action: 'log_out')
	end
end
