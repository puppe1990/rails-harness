module Api
  class ProductsController < ApplicationController
    def index
      products = Catalog::Queries::ListProducts.call
      render json: products.map { |product| Catalog::Serializers::ProductSerializer.new(product).as_json }
    end
  end
end
