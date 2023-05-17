class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :auction_lot

  validates :product_id, :auction_lot_id, presence: true
end
