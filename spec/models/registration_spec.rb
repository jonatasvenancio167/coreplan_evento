require 'rails_helper'

RSpec.describe Registration, type: :model do
  subject { build(:registration) }

  describe 'validations' do
    it { should validate_presence_of(:participant_name) }
    it { should validate_presence_of(:participant_email) }
    
    it 'allows valid email addresses' do
      should allow_value('email@example.com').for(:participant_email)
    end

    it 'rejects invalid email addresses' do
      should_not allow_value('email@com').for(:participant_email)
      should_not allow_value('email.com').for(:participant_email)
      should_not allow_value('email@.com').for(:participant_email)
      should_not allow_value('plainaddress').for(:participant_email)
      should_not allow_value('@missingusername.com').for(:participant_email)
    end

    context 'when participant_name is not unique for the same event' do
      let(:event) { create(:event) }
      let!(:existing_registration) { create(:registration, event: event, participant_name: 'John Doe') }

      it 'is not valid' do
        new_registration = build(:registration, event: event, participant_name: 'John Doe')
        expect(new_registration).not_to be_valid
        expect(new_registration.errors[:participant_name]).to include('não está disponível')
      end
    end

    context 'when event capacity is exceeded' do
      let(:event) { create(:event, capacity: 1) }

      before { create(:registration, event: event) }

      it 'is not valid' do
        new_registration = build(:registration, event: event)
        expect(new_registration).not_to be_valid
        expect(new_registration.errors[:base]).to include(I18n.t('activerecord.errors.models.registration.attributes.base.event_capacity_not_exceeded'))
      end
    end
  end
end
