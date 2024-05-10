require 'rails_helper'

RSpec.describe RabbitmqRepository, type: :model do
  describe '#publish_message' do
    subject { described_class.new(mock_connection) }
    
    let(:mock_connection) { instance_double('RabbitMQ.connection') }
    let(:mock_channel) { instance_double('Bunny::Channel') }
    let(:mock_queue) { instance_double('Bunny::Queue') }
    let(:mock_exchange) { instance_double('Bunny::Exchange') }
    let(:queue_name) { 'test_queue' }
    let(:message) { { key: 'value' } }

    before do
      allow(mock_connection).to receive(:create_channel).and_return(mock_channel)
      allow(mock_channel).to receive(:queue).with(queue_name).and_return(mock_queue)
      allow(mock_queue).to receive(:name).and_return(queue_name)
      allow(mock_channel).to receive(:default_exchange).and_return(mock_exchange)
      allow(mock_channel).to receive(:close)
    end

    it 'publishes a message to RabbitMQ' do
      expect(mock_exchange).to receive(:publish).with(message.to_json, routing_key: queue_name)
      subject.publish_message(queue_name, message)
    end
  end
end
