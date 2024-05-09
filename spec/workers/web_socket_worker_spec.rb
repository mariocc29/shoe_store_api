require 'rails_helper'

RSpec.describe WebSocketWorker, type: :worker do
  describe '#perform' do

    let(:mock_websocket) { double("WebSocket", on: nil) }
    let(:mock_message) { double("Message", data: '{"key":"value"}') }

    before :each do
      allow(WebSocket::Client::Simple).to receive(:connect).and_return(mock_websocket)
    end
    
    it 'establishes a WebSocket connection and enqueues WebSocketJob for incoming messages' do
      expect(mock_websocket).to receive(:on).with(:message).and_yield(mock_message)
      expect(WebSocketJob).to receive(:perform_later).once.with({ 'key' => 'value' })
      
      subject.perform
    end

    it 'logs WebSocket error and exits on error' do
      expect(mock_websocket).to receive(:on).with(:error).and_yield(StandardError.new('Connection error'))
      expect(Rails.logger).to receive(:error).once.with(/WebSocket error/)
      expect_any_instance_of(Object).to receive(:exit!)

      subject.perform
    end

    it 'logs WebSocket closure on close' do
      expect(mock_websocket).to receive(:on).with(:close).and_yield(1000, 'Normal closure')
      expect(Rails.logger).to receive(:info).once.with(/WebSocket closed/)

      subject.perform
    end
  end
end
