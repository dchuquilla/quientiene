class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.references :user
      t.string :plate
      t.string :chasis
      t.string :brand
      t.string :model
      t.integer :year

      t.timestamps
    end
  end
end
