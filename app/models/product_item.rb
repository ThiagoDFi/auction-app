class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :auction_lot
end
