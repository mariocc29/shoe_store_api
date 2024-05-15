class Inventory < ApplicationRecord
  validates :stock, presence: true

  belongs_to :store
  belongs_to :model
  
  after_create :send_to_sqs
  
  scope :latest_stock, -> do
    subquery = group(:store_id, :model_id).select("store_id, model_id, MAX(created_at) as max_created_at")
    where("(store_id, model_id, inventories.created_at) IN (?)", subquery)
  end
  
  scope :last_year_stock, -> do
    last_year = (Date.today - 1.year).beginning_of_year..(Date.today - 1.year).end_of_year
    subquery = group(:store_id, :model_id).select("store_id, model_id, MAX(created_at) as max_created_at").where({ created_at: last_year })
    where("(store_id, model_id, inventories.created_at) IN (?)", subquery)
  end

  private

  def send_to_sqs
    sqs = RabbitmqRepository.new( RabbitMQ.connection )
    sqs.publish_message(Rails.application.config.shoe_store[:sqs_queue_name], self)
  end
end
