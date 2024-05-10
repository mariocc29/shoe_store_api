# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::StoreApi, type: :request do
  include Rack::Test::Methods

  describe 'GET /api/v1/stores' do
    subject do
      get "/api/v1/stores/"
    end

    let!(:store) { create :store }
    
    it 'retrieves a list of stores', :aggregate_failures do
      response = subject
      data = JSON.parse(response.body)
      expect(response.status).to eq(HttpStatus::OK)
      expect(data.length).to eq(1)
    end
  end
end