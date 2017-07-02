require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe 'number of available ticket type' do
    it 'max quantity if no one ticket type is reserved' do
      event = Event.new
      event.save(validate: false)
      ticket_type = TicketType.new(max_quantity: 100, event_id: event.id)
      event.ticket_types << ticket_type
      ticket_type.save(validate: false)
      expect(ticket_type.available_count).to eq ticket_type.max_quantity
    end
  end
end
