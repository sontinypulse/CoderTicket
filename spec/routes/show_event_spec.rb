require 'rails_helper'
RSpec.describe 'routing to events/show/id', type: 'routing' do
  it 'routes events/show/id to events#show' do
		expect(get: event_path(1)).to route_to(controller: 'events', action: 'show', id: '1')
	end
end
