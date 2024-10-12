class Registration < ApplicationRecord
  belongs_to :event

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :participant_name, presence: true
  validates :participant_email, presence: true, format: { with: EMAIL_REGEX }
  validates :event, presence: true

  validates :participant_name, uniqueness: { scope: :event_id }
  
  validate :event_capacity_not_exceeded

  private

  def event_capacity_not_exceeded
    return unless event.present?

    if event.registrations.count >= event.capacity
      errors.add(:base, I18n.t('activerecord.errors.models.registration.attributes.base.event_capacity_not_exceeded'))
    end
  end
end
