class CreateBlockeds < ActiveRecord::Migration[7.0]
  def change
    create_table :blockeds do |t|
      t.string :registry_code

      t.timestamps
    end
  end
end
