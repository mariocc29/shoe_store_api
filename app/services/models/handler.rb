module Models
  class Handler
    def self.transmit
      process = Models::Process.new
      data = process.build
      message = { type: NotificationCategory::STAT_MODEL, data: }
      ActionCable.server.broadcast('NotificationChannel', message)
    end
  end
end