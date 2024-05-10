# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class ModelApi < Grape::API
    version 'v1', using: :path

    resource :models do
      desc 'Returns information models api.',
           is_array: true,
           success: Serializers::ModelSerializer,
           failure: [
             ApplicationException::BadRequestException.to_h
           ]
      get do
        models = Model.all
        present models, with: Serializers::ModelSerializer
      end
    end
  end
end
