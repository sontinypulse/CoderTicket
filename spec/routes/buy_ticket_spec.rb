require 'rails_helper'
RSpec.describe 'routing to new_event_ticket_path', type: 'routing' do
  it 'routes new_event_ticket_path to tickets#new' do
		expect(get: new_event_ticket_path(1)).to route_to(controller: 'tickets', action: 'new', event_id: '1')
	end
end
