class AddStateToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :state_province, :string
    add_column :replacement_requests, :state_province, :string
  end
end
