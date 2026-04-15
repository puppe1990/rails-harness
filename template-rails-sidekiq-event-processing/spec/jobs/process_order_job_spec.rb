require "rails_helper"

RSpec.describe ProcessOrderJob, type: :job do
  it "updates the order as processed" do
    order = Order.create!(customer_id: 1, product_id: 2, quantity: 1)

    described_class.new.perform({ "order_id" => order.id })

    expect(order.reload.processed_at).not_to be_nil
  end
end
