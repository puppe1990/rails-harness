class OrderSubmitted
  attr_reader :order_id, :customer_id

  def initialize(order_id:, customer_id:)
    @order_id = order_id
    @customer_id = customer_id
  end

  def as_json(*)
    {
      type: "order_submitted",
      order_id: order_id,
      customer_id: customer_id
    }
  end
end
