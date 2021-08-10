class AddStateToReplacemtProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :replacement_proposals, :state, :string
  end
end
