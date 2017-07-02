module TicketsHelper
  def self.check_available(params)
    msg = ''
    params[:ticket_type_ids].split.each do |ticket_type|
      reserved_tickets = params[ticket_type].to_i
      if reserved_tickets > 0
        availabe_ticket = Ticket.availabe_ticket(ticket_type, reserved_tickets)
        if availabe_ticket < 0
          msg = "Sorry, only #{reserved_tickets - availabe_ticket.abs} tickets available for #{TicketType.find_by_id(ticket_type).name}"
          break
        end
      end
    end
    msg
  end
end
