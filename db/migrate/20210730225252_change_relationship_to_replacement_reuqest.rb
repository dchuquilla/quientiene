class ChangeRelationshipToReplacementReuqest < ActiveRecord::Migration[6.1]
  def change
    rename_column :replacement_requests, :vehicle_id_id, :vehicle_id
    rename_column :replacement_requests, :user_id_id, :user_id
  end
end
