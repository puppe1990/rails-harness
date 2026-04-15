require "rails_helper"

RSpec.describe "Orders API", type: :request do
  describe "POST /orders" do
    it "accepts the request and queues processing" do
      post "/orders", params: { order: { customer_id: 1, product_id: 2, quantity: 1 } }

      expect(response).to have_http_status(:accepted)
    end
  end
end
