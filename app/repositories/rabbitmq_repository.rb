# frozen_string_literal: true

# This class represents a repository for interacting with RabbitMQ.
# It provides methods for publishing messages to RabbitMQ queues.
class RabbitmqRepository
  def initialize(connection)
    @connection = connection
  end

  def publish_message(queue_name, message)
    channel = @connection.create_channel
    queue = channel.queue(queue_name)
    channel.default_exchange.publish(message.to_json, routing_key: queue.name)
    channel.close
  end
end
