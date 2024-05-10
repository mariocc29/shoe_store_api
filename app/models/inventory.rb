class Inventory < ApplicationRecord
  validates :stock, presence: true

  belongs_to :store
  belongs_to :model
end
