class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :inventory
end
