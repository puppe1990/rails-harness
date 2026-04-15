class ProcessOrderJob
  include Sidekiq::Job

  def perform(event_payload)
    order_id = event_payload.fetch("order_id")
    ProcessOrder.call(order_id: order_id)
  end
end
