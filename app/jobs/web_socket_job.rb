class WebSocketJob < ApplicationJob
  queue_as :default

  def perform(sale)
    ActionCable.server.broadcast('SalesChannel', sale)
  end
end
