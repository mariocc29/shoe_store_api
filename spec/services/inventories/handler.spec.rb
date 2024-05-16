require 'rails_helper'

RSpec.describe Inventories::Handler do
  describe '.transmit' do
    it 'broadcasts a message' do
      
      process_double = instance_double('Inventories::Process')
      allow(Inventories::Process).to receive(:new).and_return(process_double)
      allow(process_double).to receive(:build).and_return({})

      action_cable_double = double('ActionCable')
      allow(ActionCable).to receive(:server).and_return(action_cable_double)
      expect(action_cable_double).to receive(:broadcast).with('NotificationChannel', { type: NotificationCategory::STAT_INVENTORY, data: {} })

      Inventories::Handler.transmit
    end
  end
end
