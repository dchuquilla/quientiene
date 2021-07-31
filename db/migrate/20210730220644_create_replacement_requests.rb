class CreateReplacementRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :replacement_requests do |t|
      t.references :user_id
      t.references :vehicle_id
      t.text :part_number
      t.string :short_name
      t.text :description

      t.timestamps
    end
  end
end
