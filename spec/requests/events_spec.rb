require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:event) { create(:event) }
  let(:valid_attributes) do
    {
      title: 'Novo Evento',
      description: 'Descrição do Evento',
      start_datetime: Time.current + 1.day,
      end_datetime: Time.current + 2.days,
      location: 'Localização do Evento',
      capacity: 100
    }
  end
  let(:invalid_attributes) do
    {
      title: '',
      description: '',
      start_datetime: nil,
      end_datetime: nil,
      location: '',
      capacity: nil
    }
  end

  describe "GET /index" do
    it "returns a successful response" do
      get events_url
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get event_url(event)
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Event" do
        expect {
          post events_url, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "renders a JSON response with the new event" do
        post events_url, params: { event: valid_attributes }
        expect(response).to have_http_status(:created), "expected :created but got #{response.status}: #{response.body}"
        expect(response.content_type).to include("application/json")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect {
          post events_url, params: { event: invalid_attributes }
        }.to change(Event, :count).by(0)
      end

      it "renders a JSON response with errors for the new event" do
        post events_url, params: { event: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { title: 'Updated Event Title' }
      end

      it "updates the requested event" do
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(event.title).to eq('Updated Event Title')
      end

      it "renders a JSON response with the event" do
        patch event_url(event), params: { event: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the event" do
        patch event_url(event), params: { event: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    context "when event is in the future" do
      it "destroys the requested event" do
        expect {
          delete event_url(event)
        }.to change(Event, :count).by(-1)
      end

      it "renders a JSON response with status no_content" do
        delete event_url(event)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when event has started" do
      let!(:started_event) { create(:event, start_datetime: Time.current - 1.hour, end_datetime: Time.current + 1.hour) }

      it "does not destroy the requested event" do
        expect {
          delete event_url(started_event)
        }.to change(Event, :count).by(0)
      end

      it "renders a JSON response with status unprocessable_entity" do
        delete event_url(started_event)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
