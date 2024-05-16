require 'rails_helper'

RSpec.describe Models::Handler do
  describe '.transmit' do
    it 'broadcasts a message' do
      
      process_double = instance_double('Models::Process')
      allow(Models::Process).to receive(:new).and_return(process_double)
      allow(process_double).to receive(:build).and_return({})

      action_cable_double = double('ActionCable')
      allow(ActionCable).to receive(:server).and_return(action_cable_double)
      expect(action_cable_double).to receive(:broadcast).with('NotificationChannel', { type: NotificationCategory::STAT_MODEL, data: {} })

      Models::Handler.transmit
    end
  end
end
