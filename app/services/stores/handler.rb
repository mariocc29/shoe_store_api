module Stores
  class Handler
    def self.transmit
      process = Stores::Process.new
      data = process.build
      message = { type: NotificationCategory::STAT_STORE, data: }
      ActionCable.server.broadcast('NotificationChannel', message)
    end
  end
end