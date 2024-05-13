require 'rails_helper'

RSpec.describe WebSocketJob, type: :job do
  describe "#perform" do
    let(:message) do
      {
        store: Faker::Commerce.vendor, 
        model: Faker::Commerce.product_name, 
        inventory: Faker::Number.between(from: 1, to: 10)
      }
    end

    before :each do
      allow(ActionCable.server).to receive(:broadcast)
      allow(Stores::Handler).to receive(:transmit)
      allow(Models::Handler).to receive(:transmit)
    end

    it "creates a new inventory and broadcasts a notification" do
      WebSocketJob.perform_now(JSON.parse(message.to_json()))
      inventory = Inventory.last
      expected_data = inventory.attributes.merge(store: inventory.store, model: inventory.model)
      expect(ActionCable.server).to have_received(:broadcast).with('NotificationChannel', { type: NotificationCategory::INVENTORY, data: expected_data })
    end

    it "creates a new inventory with correct attributes" do
      expect {
        WebSocketJob.perform_now(JSON.parse(message.to_json()))
      }.to change { Inventory.count }.by(1)

      inventory = Inventory.last
      expect(inventory.store.name).to eq(message[:store])
      expect(inventory.model.name).to eq(message[:model])
      expect(inventory.stock).to eq(message[:inventory])
    end

    it "logs error if there's an exception" do
      allow_any_instance_of(Inventory).to receive(:save).and_raise(StandardError.new("Test error"))

      expect(Rails.logger).to receive(:error).with("WebSocketJob error: Test error")

      WebSocketJob.perform_now(JSON.parse(message.to_json()))
    end
  end
end
