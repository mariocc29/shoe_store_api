class Model < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :inventory

  after_create -> { Models::Handler.transmit }
end
