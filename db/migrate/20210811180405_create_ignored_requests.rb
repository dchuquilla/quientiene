class CreateIgnoredRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :ignored_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :replacement_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
