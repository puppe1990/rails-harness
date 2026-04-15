class ProcessOrder
  def self.call(order_id:)
    order = Order.find(order_id)
    order.update!(processed_at: Time.current)
  end
end
