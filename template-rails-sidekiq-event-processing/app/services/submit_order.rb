class SubmitOrder
  def self.call(order_params:)
    order = Order.create!(order_params)
    event = OrderSubmitted.new(order_id: order.id, customer_id: order.customer_id)

    ProcessOrderJob.perform_async(event.as_json)

    { order_id: order.id, event: event }
  end
end
