module Catalog
  module Serializers
    class ProductSerializer
      def initialize(product)
        @product = product
      end

      def as_json(*)
        {
          id: @product.id,
          name: @product.name
        }
      end
    end
  end
end
