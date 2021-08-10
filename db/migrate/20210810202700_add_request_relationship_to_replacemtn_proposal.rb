class AddRequestRelationshipToReplacemtnProposal < ActiveRecord::Migration[6.1]
  def change
    add_reference :replacement_proposals, :replacement_request, null: false, foreign_key: true
  end
end
