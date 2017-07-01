require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to validation, before_save"

  describe '.upcoming' do
    it 'returns [] when there are no events' do
      expect(Event.upcoming).to eq []
    end

    it 'returns 1 event there is 1 event' do
      event = Event.new(starts_at_date: 1.day.from_now, starts_at_hour: '10', starts_at_minute: '30')
      event.save(validate: false)
      expect(Event.upcoming).to match_array [event]
    end

    it 'returns only upcoming event' do
      a = Event.new(starts_at_date: 1.day.ago, starts_at_hour: '10', starts_at_minute: '30')
      b = Event.new(starts_at_date: 1.day.from_now, starts_at_hour: '10', starts_at_minute: '30')
      c = Event.new(starts_at_date: Date.parse('2017/7/7'), starts_at_hour: '10', starts_at_minute: '30')
      b.save(validate: false)
      c.save(validate: false)
      a.save(validate: false)
      expect(Event.upcoming).to match_array [b, c]
    end

    it 'returns [] if no upcoming events' do
      a = Event.new(starts_at_date: 1.day.ago, starts_at_hour: '10', starts_at_minute: '30')
      a.save(validate: false)
      expect(Event.upcoming).to match_array []
    end
  end

  describe '#venue_name' do
    it 'returns nill if no venue' do
      event = Event.new
      expect(event.venue_name).to eq nil
    end
    it 'returns venue name' do
      venue = Venue.new name: 'Lan Anh'
      event = Event.new venue: venue
      expect(event.venue_name).to eq venue.name
    end
  end

  describe '.search' do
    it 'returns [] if no venue' do
      a = Event.new starts_at: 1.day.ago, name: 'Event 1'
      b = Event.new starts_at: 1.day.from_now, name: 'Event 2'
      c = Event.new starts_at: Date.parse('2017/7/7'), name: 'Event 3'
      b.save(validate: false)
      c.save(validate: false)
      a.save(validate: false)
      expect(Event.search('no results')).to match_array([])
    end
    it 'returns events that matched' do
      a = Event.new starts_at: 1.day.ago, name: 'Event 1'
      b = Event.new starts_at: 1.day.from_now, name: 'Event 2'
      c = Event.new starts_at: Date.parse('2017/7/7'), name: 'Event 3'
      b.save(validate: false)
      c.save(validate: false)
      a.save(validate: false)
      expect(Event.search('Event')).to match_array([a, b, c])
    end
  end

  describe '#event_type_name' do
    it 'must have event type' do
      event = Event.new
      event.valid?
      event.errors[:category].should include("can't be blank")
    end

    it 'should not raise error if has event type name' do
      category = Category.new name: 'Entertainment'
      event = Event.new category: category
      event.valid?
      event.errors[:category].should_not include("can't be blank")
    end

    it 'returns event type name' do
      category = Category.new name: 'Entertainment'
      event = Event.new category: category
      event.save(validate: false)
      expect(event.event_type_name).to eq category.name
    end
  end
end
