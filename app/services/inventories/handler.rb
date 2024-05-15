# frozen_string_literal: true

module Inventories
  class Handler
    def self.transmit
      process = Inventories::Process.new
      data = process.build
      message = { type: NotificationCategory::STAT_INVENTORY, data: }
      ActionCable.server.broadcast('NotificationChannel', message)
    end
  end
end
