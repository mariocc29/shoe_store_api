require 'rails_helper'

RSpec.describe SalesChannel, type: :channel do
  it 'successfully subscribes to SalesChannel stream' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('SalesChannel')
  end

  it 'successfully unsubscribes from SalesChannel' do
    subscribe
    unsubscribe
    expect(subscription).to_not have_streams
  end
end
