require 'rails_helper'

RSpec.describe NotificationChannel, type: :channel do
  it 'successfully subscribes to NotificationChannel stream' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('NotificationChannel')
  end

  it 'successfully unsubscribes from NotificationChannel' do
    subscribe
    unsubscribe
    expect(subscription).to_not have_streams
  end
end
