require 'rails_helper'

RSpec.describe Stores::Handler do
  describe '.transmit' do
    it 'broadcasts a message' do
      
      process_double = instance_double('Stores::Process')
      allow(Stores::Process).to receive(:new).and_return(process_double)
      allow(process_double).to receive(:build).and_return({})

      action_cable_double = double('ActionCable')
      allow(ActionCable).to receive(:server).and_return(action_cable_double)
      expect(action_cable_double).to receive(:broadcast).with('NotificationChannel', { type: NotificationCategory::STAT_STORE, data: {} })

      Stores::Handler.transmit
    end
  end
end
