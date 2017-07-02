class TicketsController < ApplicationController
  def new
    @event = Event.find_by_id(params[:event_id])
  end

  def buy
    available_msg = TicketsHelper.check_available(params)
    if available_msg.blank?
      params[:ticket_type_ids].split.each do |ticket_type|
        Ticket.book_ticket(current_user.id, ticket_type, params[ticket_type].to_i)
      end
      redirect_to upcoming_path
    else
      flash.now[:error] = available_msg
      @event = Event.find_by_id(params[:event_id])
      render :new
    end
  end
end
