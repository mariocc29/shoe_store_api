class Inventory < ApplicationRecord
  validates :stock, presence: true

  belongs_to :store
  belongs_to :model

  after_create :send_to_sqs

  private

  def send_to_sqs
    sqs = RabbitmqRepository.new( RabbitMQ.connection )
    sqs.publish_message(Rails.application.config.shoe_store[:sqs_queue_name], self)
  end
end
