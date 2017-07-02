require 'rails_helper'
RSpec.describe 'routing buy', type: 'routing' do
  it 'routes /tickets/buy to tickets#buy' do
		expect(post: tickets_buy_path).to route_to(controller: 'tickets', action: 'buy')
	end
end
