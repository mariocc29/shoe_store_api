module Stores
  class Handler
    def self.transmit
      process = Stores::Process.new
      data = process.build
      ActionCable.server.broadcast('NotificationChannel', { type: NotificationCategory::STORE, data: })
    end
  end
end