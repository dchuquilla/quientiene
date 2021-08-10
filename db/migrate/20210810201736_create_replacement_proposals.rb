class CreateReplacementProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :replacement_proposals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.boolean :original
      t.string :brand
      t.string :origin
      t.string :life_time
      t.string :target
      t.string :delivery_time
      t.string :conditions

      t.timestamps
    end
  end
end
