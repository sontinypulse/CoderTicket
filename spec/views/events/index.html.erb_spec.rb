require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  it 'renders event in CSS of article' do
    event = Event.new(name: 'Event1', starts_at_date: 1.day.from_now, starts_at_hour: '10', starts_at_minute: '30')
    event.save(validate: false)
    assign(:events, [event])
    render
    rendered.should have_content(event.name)
    rendered.should have_selector("article#event_#{event.id}")
  end
end
