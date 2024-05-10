# frozen_string_literal: true

module V1
  module Serializers
    # Defines the structure for serializing deck information.
    class ModelSerializer < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Identifier of the model.' }
      expose :name, documentation: { type: String, desc: 'Name of the model.' }
    end
  end
end
