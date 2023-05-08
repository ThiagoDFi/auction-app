class RemoveAuctionLotFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :products, :auction_lot, null: false, foreign_key: true
  end
end
