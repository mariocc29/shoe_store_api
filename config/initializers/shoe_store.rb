# frozen_string_literal: true

Rails.application.config.shoe_store = {
  ws_sales: ENV['WEBSOCKET_URL'],
  sqs_queue_name: ENV['RABBITMQ_QUEUE_NAME']
}