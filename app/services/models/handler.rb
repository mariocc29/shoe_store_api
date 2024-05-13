module Models
  class Handler
    def self.transmit
      process = Models::Process.new
      data = process.build
      ActionCable.server.broadcast('NotificationChannel', { type: NotificationCategory::MODEL, data: })
    end
  end
end