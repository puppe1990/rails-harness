module Catalog
  class Product < ApplicationRecord
    self.table_name = "products"

    validates :name, presence: true

    scope :active, -> { where(active: true) }
  end
end
