# frozen_string_literal: true

# Channel for broadcasting sales-related updates.
# This channel handles subscription to 'SalesChannel' stream.
class SalesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'SalesChannel'
  end

  def unsubscribed; end
end
