# frozen_string_literal: true

module Inventories
  class Process
    def build
      current_inventory = get_current_inventory_data
      last_year_inventory = get_last_year_inventory_data

      {
        total: current_inventory[:total],
        inventory_growth: inventory_growth(current_inventory[:total], last_year_inventory),
        current_inventory: current_inventory[:inventory]
      }
    end

    private

    def get_current_inventory_data
      inventory = Inventory.select('inventories.model_id, inventories.store_id, inventories.stock, stores.name AS storename, models.name AS modelname')
                  .joins(:model)
                  .joins(:store).latest_stock

        
      total = 0
      inventory.each {|item| total += item[:stock]}
      
      { inventory:, total: }
    end

    def get_last_year_inventory_data
      Inventory.last_year_stock.sum(:stock)
    end

    def inventory_growth(current_inventory, last_year_inventory)
      change_in_count = current_inventory - last_year_inventory

      percentage_change = if last_year_inventory.zero? && current_inventory.positive?
                            100.0
                          elsif last_year_inventory.zero? && current_inventory.zero?
                            0.0
                          else
                            (change_in_count.to_f / last_year_inventory.abs) * 100
                          end

      { change_in_count:, percentage_change: percentage_change.round(2) }
    end
  end
end
