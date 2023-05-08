class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :auction_lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
