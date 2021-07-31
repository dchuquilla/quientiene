class ChangeVehicleRelationshipToReplacementReuqest < ActiveRecord::Migration[6.1]
  def change
    rename_column :replacement_requests, :car_id, :vehicle_id
  end
end
