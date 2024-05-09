# frozen_string_literal: true

# WebSocketWorker class responsible for establishing a WebSocket connection
# and handling incoming messages, errors, and connection closures.
# It includes Sidekiq::Worker for asynchronous processing of messages.
class WebSocketWorker
  include Sidekiq::Worker

  def perform
    ws = WebSocket::Client::Simple.connect Rails.application.config.shoe_store[:ws_sales]

    ws.on :message do |message|
      WebSocketJob.perform_later(JSON.parse(message.data))
    end

    ws.on :error do |e|
      Rails.logger.error "WebSocket error: #{e.message}"
      exit!
    end

    ws.on :close do |code, reason|
      Rails.logger.info "WebSocket closed with code: #{code} and reason: #{reason}"
    end
  end
end
