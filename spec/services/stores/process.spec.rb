require 'rails_helper'

RSpec.describe Stores::Process do
  describe '#build' do
    it 'returns the correct data' do
      create_list(:store, 5, created_at: Time.new(Time.now.year))
      create_list(:store, 3, created_at: Time.new(Time.now.year - 1))

      process = Stores::Process.new
      result = process.build

      current_year_count = Store.where("EXTRACT(YEAR FROM created_at) = ?", Time.now.year).count
      previous_year_count = Store.where("EXTRACT(YEAR FROM created_at) = ?", Time.now.year - 1).count
      change_in_count = current_year_count - previous_year_count
      percentage_change = (change_in_count.to_f / previous_year_count) * 100
      
      expect(result).to eq({
        total: Store.all.count,
        stores_growth: {
          change_in_count: change_in_count,
          percentage_change: percentage_change.abs.round(2)
        }
      })
    end
  end
end
