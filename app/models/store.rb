class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :inventories
  has_many :models, through: :inventories

  after_create -> { Stores::Handler.transmit }
end
