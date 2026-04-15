module Catalog
  module Queries
    class ListProducts
      def self.call
        Product.active.order(created_at: :desc)
      end
    end
  end
end
