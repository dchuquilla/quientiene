class AddStateToReplacementRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :replacement_requests, :state, :string
  end
end
