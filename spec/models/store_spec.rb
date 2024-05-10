require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    let(:params) do
      { name: Faker::Commerce.vendor }
    end

    it { should validate_presence_of(:name) }

    it 'validates uniqueness of label' do
      create(:store, name: params[:name])
      store = Store.new(params)
      store.valid?

      expect(store.errors[:name]).to include('has already been taken')
    end
  end
end
