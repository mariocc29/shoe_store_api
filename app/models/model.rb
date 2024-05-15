class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :inventories
  has_many :stores, through: :inventories

  after_create -> { Models::Handler.transmit }
end
