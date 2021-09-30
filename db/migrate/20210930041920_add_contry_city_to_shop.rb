class AddContryCityToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :country, :string
    add_column :shops, :city, :string
    add_column :replacement_requests, :country, :string
    add_column :replacement_requests, :city, :string
  end
end
