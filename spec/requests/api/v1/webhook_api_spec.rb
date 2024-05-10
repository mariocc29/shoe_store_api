# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::WebhookApi, type: :request do
  include Rack::Test::Methods

  describe 'POST /api/v1/anomalies' do
    subject do
      post "/api/v1/anomalies/", params
    end

    let!(:store) { create :store }
    let!(:model) { create :model }

    before do
      allow(ActionCable.server).to receive(:broadcast)
    end

    context 'with valid parameters' do
      let(:params) { {store_id: store.id, model_id: model.id, status: 'test-status'} }
      let(:message) { {store: store, model: model, status: 'test-status'} }
      
      it 'notifies an anomaly', :aggregate_failures do
        expect(ActionCable.server).to have_received(:broadcast).with('NotificationChannel', { type: NotificationCategory::ANOMALY, data: message })

        response = subject
        data = JSON.parse(response.body)
        expect(response.status).to eq(HttpStatus::OK)
      end
    end
  end
end