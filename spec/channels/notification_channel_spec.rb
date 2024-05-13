require 'rails_helper'

RSpec.describe NotificationChannel, type: :channel do

  before :each do
    allow(Stores::Handler).to receive(:transmit)
    allow(Models::Handler).to receive(:transmit)
  end

  it 'successfully subscribes to NotificationChannel stream' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('NotificationChannel')

    expect(Stores::Handler).to have_received(:transmit)
    expect(Models::Handler).to have_received(:transmit)
  end

  it 'successfully unsubscribes from NotificationChannel' do
    subscribe
    unsubscribe
    expect(subscription).to_not have_streams
  end
end
