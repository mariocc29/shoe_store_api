# frozen_string_literal: true

# Module for interacting with RabbitMQ.
module RabbitMQ
  def self.connection
    return @connection if @connection&.open?

    @connection = Bunny.new(
      host: ENV['RABBITMQ_HOST'],
      port: ENV['RABBITMQ_PORT'],
      user: ENV['RABBITMQ_USER'],
      pass: ENV['RABBITMQ_PASS']
    )

    @connection.start
    @connection
  end

  def self.close_connection
    @connection.close if @connection&.open?
    @connection = nil
  end
end

at_exit { RabbitMQ.close_connection }
