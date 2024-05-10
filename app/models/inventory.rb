class Inventory < ApplicationRecord
  validates :inventory, presence: true

  belongs_to :store
  belongs_to :model
end
