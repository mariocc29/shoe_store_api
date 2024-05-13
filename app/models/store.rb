class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :inventory

  after_create -> { Stores::Handler.transmit }
end
