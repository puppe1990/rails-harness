module Api
  class OrdersController < ApplicationController
    def create
      result = SubmitOrder.call(order_params: order_params.to_h)

      render json: { order_id: result[:order_id], status: "queued" }, status: :accepted
    end

    private

    def order_params
      params.require(:order).permit(:customer_id, :product_id, :quantity)
    end
  end
end
