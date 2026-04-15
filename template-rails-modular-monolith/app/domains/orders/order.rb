module Orders
  class Order < ApplicationRecord
    self.table_name = "orders"

    validates :product_id, presence: true
  end
end
