require 'rails_helper'

RSpec.describe Inventories::Process do
  describe '#build' do
    it 'returns the correct data' do
      inventory1 = create(:inventory, stock: 10)
      inventory2 = create(:inventory, stock: 15)

      process = Inventories::Process.new
      result = process.build

      inventory = Inventory.select('inventories.model_id, inventories.store_id, inventories.stock, stores.name AS storename, models.name AS modelname')
                  .joins(:model)
                  .joins(:store)
                  .latest_stock

      expect(result).to eq({
        total: 25,
        inventory_growth: { change_in_count: 25, percentage_change: 100.0 },
        current_inventory: inventory
      })
    end
  end
end
