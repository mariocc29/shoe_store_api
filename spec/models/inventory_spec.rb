require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe "validations" do
    it { should validate_presence_of(:stock) }
  end

  describe "associations" do
    it { should belong_to(:store) }
    it { should belong_to(:model) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      let(:inventory) { create(:inventory) }
      let(:mock_sqs) { instance_double('RabbitmqRepository') }

      before do
        allow(RabbitmqRepository).to receive(:new).and_return(mock_sqs)
      end
      
      it 'calls send_to_sqs and publishes a message to RabbitMQ' do
        expect(mock_sqs).to receive(:publish_message)
        inventory.save
      end
    end
  end
end
