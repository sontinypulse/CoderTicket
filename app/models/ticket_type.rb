class TicketType < ActiveRecord::Base
  belongs_to :event
  def available_count
    booked_tickets_count = Ticket.where(ticket_type_id: id).count
    max_quantity - booked_tickets_count
  end
end
