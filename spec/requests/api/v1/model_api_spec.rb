# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ModelApi, type: :request do
  include Rack::Test::Methods

  describe 'GET /api/v1/models' do
    subject do
      get "/api/v1/models/"
    end

    let!(:model) { create :model }
    
    it 'retrieves a list of models', :aggregate_failures do
      response = subject
      data = JSON.parse(response.body)
      expect(response.status).to eq(HttpStatus::OK)
      expect(data.length).to eq(1)
    end
  end
end