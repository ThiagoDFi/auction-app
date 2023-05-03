class AddRegistryCodeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :registry_code, :string
  end
end
