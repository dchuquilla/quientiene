class CreateIgnoredProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :ignored_proposals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :replacement_proposal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
