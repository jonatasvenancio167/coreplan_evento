# app/serializers/event_serializer.rb
class EventSerializer < ActiveModel::Serializer
  attributes :title, :description, :start_datetime, :end_datetime, :location, :registered_count, :vacancies_available

  def start_datetime
    object.start_datetime.strftime('%d/%m/%Y %H:%M')
  end

  def end_datetime
    object.end_datetime.strftime('%d/%m/%Y %H:%M')
  end

  def registered_count
    object.registrations.count
  end

  def vacancies_available
    object.registrations.count < object.capacity
  end
end
