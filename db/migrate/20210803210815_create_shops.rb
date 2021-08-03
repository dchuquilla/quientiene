class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :ruc
      t.string :phone1
      t.string :phone2
      t.string :address
      t.string :contact_name
      t.string :sector

      t.timestamps
    end
  end
end
