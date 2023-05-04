class CreateAuctionLots < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_lots do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :minimum_value
      t.integer :diff_value
      t.string :admin_record
      t.string :admin_approve
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
