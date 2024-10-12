require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_datetime) }
    it { should validate_presence_of(:end_datetime) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:capacity) }
    it { should validate_numericality_of(:capacity).only_integer.is_greater_than(0) }

    context 'when start_datetime is after end_datetime' do
      before { subject.start_datetime = subject.end_datetime + 1.hour }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:start_datetime]).to include(I18n.t('activerecord.errors.models.event.attributes.base.start_datetime_before_end_datetime'))
      end
    end

    context 'when there is a conflicting event' do
      before do
        create(:event, start_datetime: subject.start_datetime - 1.hour, end_datetime: subject.start_datetime + 1.hour, location: subject.location)
      end

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:base]).to include(I18n.t('activerecord.errors.models.event.attributes.base.no_conflicts_events'))
      end
    end
  end

  describe '#registered_count' do
    it 'returns the number of registrations' do
      event = create(:event)
      create_list(:registration, 5, event: event)
      expect(event.registered_count).to eq(5)
    end
  end

  describe '#vacancies_available?' do
    context 'when there are fewer registrations than capacity' do
      it 'returns true' do
        event = create(:event, capacity: 10)
        create_list(:registration, 5, event: event)
        expect(event.vacancies_available?).to be true
      end
    end

    context 'when the number of registrations is equal to or greater than capacity' do
      it 'returns false' do
        event = create(:event, capacity: 10)
        create_list(:registration, 10, event: event)
        expect(event.vacancies_available?).to be false
      end
    end
  end
end
