# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class StoreApi < Grape::API
    version 'v1', using: :path

    resource :stores do
      desc 'Returns information stores api.',
           is_array: true,
           success: Serializers::StoreSerializer,
           failure: [
             ApplicationException::BadRequestException.to_h
           ]
      get do
        stores = Store.all
        present stores, with: Serializers::StoreSerializer
      end
    end
  end
end
