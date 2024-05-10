# frozen_string_literal: true

module V1
  module Serializers
    # Defines the structure for serializing deck information.
    class StoreSerializer < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Identifier of the store.' }
      expose :name, documentation: { type: String, desc: 'Name of the store.' }
    end
  end
end
