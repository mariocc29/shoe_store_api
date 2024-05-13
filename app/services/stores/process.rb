module Stores
  class Process
    def build
      {
        total: Store::all.count,
        stores_growth: stores_growth
      }
    end

    private

    def stores_growth
      current_year = Time.now.year
      previous_year = current_year - 1

      stores_per_year = Store.select("EXTRACT(YEAR FROM created_at) AS year, COUNT(1) AS total_items")
        .group("EXTRACT(YEAR FROM created_at)")
        .having("ROUND(EXTRACT(YEAR FROM created_at)) = ? OR ROUND(EXTRACT(YEAR FROM created_at)) = ?", current_year, previous_year)
        .order("year ASC")
      
      current_year_count = stores_per_year.last&.total_items
      previous_year_count = stores_per_year.first&.total_items
      
      change_in_count = current_year_count - previous_year_count
      percentage_change = (change_in_count.to_f / previous_year_count) * 100
      
      { change_in_count:, percentage_change: percentage_change.abs.round(2) }
    end
  end
end