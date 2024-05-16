require 'rails_helper'

RSpec.describe Models::Process do
  describe '#build' do
    it 'returns the correct data' do
      create_list(:model, 5, created_at: Time.new(Time.now.year))
      create_list(:model, 3, created_at: Time.new(Time.now.year - 1))

      process = Models::Process.new
      result = process.build

      current_year_count = Model.where("EXTRACT(YEAR FROM created_at) = ?", Time.now.year).count
      previous_year_count = Model.where("EXTRACT(YEAR FROM created_at) = ?", Time.now.year - 1).count
      change_in_count = current_year_count - previous_year_count
      percentage_change = (change_in_count.to_f / previous_year_count) * 100
      
      expect(result).to eq({
        total: Model.all.count,
        models_growth: {
          change_in_count: change_in_count,
          percentage_change: percentage_change.abs.round(2)
        }
      })
    end
  end
end
