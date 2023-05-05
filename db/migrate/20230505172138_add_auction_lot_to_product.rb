class AddAuctionLotToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :auction_lot, null: false, foreign_key: true, default: 0
  end
end
