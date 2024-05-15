# frozen_string_literal: true

# Channel for broadcasting sales-related updates.
# This channel handles subscription to 'NotificationChannel' stream.
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'NotificationChannel'
    Stores::Handler.transmit
    Models::Handler.transmit
    Inventories::Handler.transmit
  end

  def unsubscribed; end
end
