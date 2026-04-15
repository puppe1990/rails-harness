module Orders
  module Commands
    class PlaceOrder
      def self.call(product_id:)
        Order.create!(product_id: product_id)
      end
    end
  end
end
