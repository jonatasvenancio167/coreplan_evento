class Event < ApplicationRecord
  has_many :registrations

  validates :title, presence: true
  validates :description, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :location, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :start_datetime_before_end_datetime
  validate :no_conflicts_events, if: :start_or_end_datetime_changed?

  def registered_count
    registrations.count
  end

  def vacancies_available?
    registered_count < capacity
  end

  private

  def start_datetime_before_end_datetime
    return if start_datetime.nil? || end_datetime.nil?
    
    return if start_datetime < end_datetime

    errors.add(:start_datetime, I18n.t('activerecord.errors.models.event.attributes.base.start_datetime_before_end_datetime'))
  end

  def no_conflicts_events
    conflicting_events = Event.where(location: location)
                              .where.not(id: id)
                              .where('start_datetime < ? AND end_datetime > ?', end_datetime, start_datetime)

    return if conflicting_events.empty?

    errors.add(:base, I18n.t('activerecord.errors.models.event.attributes.base.no_conflicts_events'))
  end

  def start_or_end_datetime_changed?
    start_datetime_changed? || end_datetime_changed?
  end
end
