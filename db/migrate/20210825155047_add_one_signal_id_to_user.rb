class AddOneSignalIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :onesignal_id, :string
  end
end
