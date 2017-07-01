class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at_date, :starts_at_hour, :starts_at_minute
  validates_uniqueness_of :name, uniqueness: { scope: [:venue, :starts_at] }

  def self.upcoming
    Event.where('starts_at > ?', Time.now)
  end

  def self.search(search)
    Event.where('name ILIKE ?', "%#{search}%")
  end

  delegate :name, to: :category, allow_nil: true, prefix: 'event_type'
  delegate :name, to: :venue, allow_nil: true, prefix: true
  delegate :full_address , to: :venue, allow_nil: true, prefix: true
  before_save :update_start_end_datetime

  def update_start_end_datetime
    self.starts_at = "#{self.starts_at_date} #{self.starts_at_hour}:#{self.starts_at_minute}"
    self.ends_at = "#{self.ends_at_date} #{self.ends_at_hour}:#{self.ends_at_minute}"
  end
end
