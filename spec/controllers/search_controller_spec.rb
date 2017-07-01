require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    it 'response 200 when visiting' do
      get :search
      expect(response).to have_http_status(200)
    end
    it 'returns [] when no any matched events for valid text search' do
      event1 = Event.new starts_at: 1.day.from_now, name: 'Event 1'
      event2 = Event.new starts_at: 1.day.ago, name: 'Event 2'
      event1.save(validate: false)
      event2.save(validate: false)
      get :search, params: { search: 'No Results' }
      expect(assigns(:events)).to match_array([])
    end

    it 'returns an event when there is one matched event' do
      event1 = Event.new starts_at: 1.day.from_now, name: 'Event 1'
      event2 = Event.new starts_at: 1.day.ago, name: 'Event 2'
      event1.save(validate: false)
      event2.save(validate: false)
      get :search, params: { search: 'Event 1' }
      expect(assigns(:events)).to match_array([event1])
    end

    it 'returns all events if no param search' do
      event1 = Event.new starts_at: 1.day.from_now, name: 'Event 1'
      event2 = Event.new starts_at: 1.day.ago, name: 'Event 2'
      event1.save(validate: false)
      event2.save(validate: false)
      get :search
      expect(assigns(:events)).to match_array([event1, event2])
    end
  end
end
