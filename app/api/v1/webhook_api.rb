# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class WebhookApi < Grape::API
    version 'v1', using: :path

    resource :anomalies do
      desc 'Webhook to receive of inventory anomalies.',
           success: { code: 200 },
           failure: [
             ApplicationException::BadRequestException.to_h
           ]
      params do
        requires :store_id, type: String, desc: 'Identifier of the store.'
        requires :model_id, type: String, desc: 'Identifier of the model.'
        requires :status, type: String, desc: 'Anomaly status.'
      end
      post do
        message = {
          store: Store::find_by_id(params[:store_id]),
          model: Model::find_by_id(params[:model_id]),
          status: params[:status]
        }

        ActionCable.server.broadcast('NotificationChannel', { type: NotificationCategory::ANOMALY, data: message })

        status 200
        { message: 'Success' }
      end
    end
  end
end
