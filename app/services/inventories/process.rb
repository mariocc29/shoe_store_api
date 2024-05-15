# frozen_string_literal: true

module Inventories
  class Process
    def build
      current_inventory = get_current_inventory_data
      last_year_inventory = get_last_year_inventory_data

      {
        total: current_inventory[:total],
        inventory_growth: inventory_growth(current_inventory[:total], last_year_inventory),
        current_inventory: current_inventory[:stores]
      }
    end

    private

    def get_current_inventory_data
      stores = Store.joins(:models)
                    .select('stores.id AS store_id, stores.name AS store_name, models.id AS model_id, models.name AS model_name, MAX(inventories.stock) AS last_stock')
                    .joins('LEFT JOIN inventories ON inventories.store_id = stores.id AND inventories.model_id = models.id')
                    .group('stores.id, models.id')

      total = 0
      stores.each { |store| total += store.last_stock }

      { total:, stores: }
    end

    def get_last_year_inventory_data
      last_year = (Date.today - 1.year).beginning_of_year..(Date.today - 1.year).end_of_year

      stores = Store.joins(:models)
                    .select('stores.name AS store_name, models.name AS model_name, MAX(inventories.stock) AS last_stock')
                    .joins('LEFT JOIN inventories ON inventories.store_id = stores.id AND inventories.model_id = models.id')
                    .where(inventories: { created_at: last_year })
                    .group('stores.id, models.id')

      total = 0
      stores.each { |store| total += store.last_stock }

      total
    end

    def inventory_growth(current_inventory, last_year_inventory)
      change_in_count = current_inventory - last_year_inventory

      percentage_change = if last_year_inventory.zero? && current_inventory.positive?
                            100.0
                          else
                            (change_in_count.to_f / last_year_inventory.abs) * 100
                          end

      { change_in_count:, percentage_change: percentage_change.round(2) }
    end
  end
end
