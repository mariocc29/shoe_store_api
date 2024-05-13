# frozen_string_literal: true

# Job to process WebSocket messages and store inventory.
class WebSocketJob < ApplicationJob
  queue_as :default

  def perform(message)
    inventory = persists(message)
    build(inventory) do | data |
      ActionCable.server.broadcast('NotificationChannel', { type: NotificationCategory::TRANSACTION, data: })
    end
  rescue StandardError => e
    Rails.logger.error "WebSocketJob error: #{e.message}"
  end

  private

  def persists(message)
    inventory = Inventory.new
    inventory.store = Store.find_or_create_by(name: message['store'])
    inventory.model = Model.find_or_create_by(name: message['model'])
    inventory.stock = message['inventory']
    inventory.save

    inventory
  end

  def build(inventory)
    yield( inventory.attributes.merge(store: inventory.store, model: inventory.model) )
  end
end
