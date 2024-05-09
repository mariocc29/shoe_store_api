class WebSocketJob < ApplicationJob
  queue_as :default

  def perform(inventory)
    ActionCable.server.broadcast('NotificationChannel', inventory)
  end
end
