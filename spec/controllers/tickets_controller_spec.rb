require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: { event_id: 1 }
      expect(response).to have_http_status(:success)
    end
    it 'loads no event for @event' do
      get :new, params: { event_id: 1 }
      expect(assigns(:event)).to eq nil
    end

    it 'loads event for @event' do
      event = Event.new
      event.save(validate: false)
      get :new, params: { event_id: event.id }
      expect(assigns(:event)).to eq event
    end
  end

end
