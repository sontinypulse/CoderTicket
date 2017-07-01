require 'rails_helper'
RSpec.describe 'routing to /search', type: 'routing' do
  it 'routes /search to serach#search' do
		expect(get: '/search').to route_to(controller: 'search', action: 'search')
	end
end
