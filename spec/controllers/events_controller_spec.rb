require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    it 'response 200 when visiting' do
      get :index
      expect(response).to have_http_status(200)
    end
    it 'renders index.html template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'loads all upcoming event into @events' do
      event1 = Event.new(starts_at_date: 1.day.from_now, starts_at_hour: '10', starts_at_minute: '30')
      event2 = Event.new(starts_at_date: 1.day.ago, starts_at_hour: '10', starts_at_minute: '30')
      event1.save(validate: false)
      event2.save(validate: false)
      get :index
      expect(assigns(:events)).to match_array([event1])
    end
  end
  describe 'GET #show' do
    it 'response 200 when visiting' do
      event = Event.new
      event.save(validate: false)
      get :show, id: event.id
      expect(response).to have_http_status(200)
    end
    it 'assigns the requested event to @event' do
      event = Event.new
      event.save(validate: false)
      get :show, id: event.id
      assigns(:event).should eq(event)
    end
    it 'renders the #show view' do
      event = Event.new
      event.save(validate: false)
      get :show, id: event.id
      response.should render_template :show
    end
  end
end
