require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe "validations" do
    it { should validate_presence_of(:inventory) }
  end

  describe "associations" do
    it { should belong_to(:store) }
    it { should belong_to(:model) }
  end
end
