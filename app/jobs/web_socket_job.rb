# frozen_string_literal: true

# Job to process WebSocket messages and store inventory.
class WebSocketJob < ApplicationJob
  queue_as :default

  def perform(message)
    inventory = Inventory.new
    inventory.store = Store.find_or_create_by(name: message['store'])
    inventory.model = Model.find_or_create_by(name: message['model'])
    inventory.stock = message['inventory']

    begin
      inventory.save
      inventory.includes(:store, :model)
      ActionCable.server.broadcast('NotificationChannel', { type: NotificationCategory::TRANSACTION, data: inventory })
    rescue StandardError => e
      Rails.logger.error "WebSocketJob error: #{e.message}"
    end
  end
end
