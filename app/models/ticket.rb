class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_type
  def self.availabe_ticket(ticket_type, reserved_tickets)
    TicketType.find_by_id(ticket_type).available_count - reserved_tickets
  end

  def self.book_ticket(user_id, ticket_type, quantity)
    quantity.times do
      Ticket.create(
        user_id: user_id,
        ticket_type_id: ticket_type,
        code: SecureRandom.hex(16)
      )
    end
  end
end
