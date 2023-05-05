class RemoveProductFromAuctionLot < ActiveRecord::Migration[7.0]
  def change
    remove_reference :auction_lots, :product, null: false, foreign_key: true
  end
end
