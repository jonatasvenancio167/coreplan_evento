require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let!(:event) { create(:event) }
  let!(:registration) { create(:registration, event: event) }
  let(:valid_attributes) { { participant_name: 'John Doe', participant_email: 'john.doe@example.com', event_id: event.id } }
  let(:invalid_attributes) { { participant_name: '', participant_email: 'invalid_email', event_id: nil } }

  describe "GET /index" do
    it "returns a successful response" do
      get registrations_url
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get registration_url(registration)
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Registration" do
        expect {
          post registrations_url, params: { registration: valid_attributes }
        }.to change(Registration, :count).by(1)
      end

      it "renders a JSON response with the new registration" do
        post registrations_url, params: { registration: valid_attributes }
        expect(response).to have_http_status(:created), "expected :created but got #{response.status}: #{response.body}"
        expect(response.content_type).to include("application/json")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Registration" do
        expect {
          post registrations_url, params: { registration: invalid_attributes }
        }.to change(Registration, :count).by(0)
      end

      it "renders a JSON response with errors for the new registration" do
        post registrations_url, params: { registration: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end

    context "when event capacity is exceeded" do
      it "does not create a new Registration" do
        event.update(capacity: 1)
        begin
          create(:registration, event: event)
        rescue ActiveRecord::RecordInvalid
          # Captura a exceção para que o teste possa continuar
        end

        expect {
          post registrations_url, params: { registration: valid_attributes }
        }.to change(Registration, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { participant_name: 'Jane Doe' } }

      it "updates the requested registration" do
        patch registration_url(registration), params: { registration: new_attributes }
        registration.reload
        expect(registration.participant_name).to eq('Jane Doe')
      end

      it "renders a JSON response with the registration" do
        patch registration_url(registration), params: { registration: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the registration" do
        patch registration_url(registration), params: { registration: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested registration" do
      expect {
        delete registration_url(registration)
      }.to change(Registration, :count).by(-1)
    end
  end
end
