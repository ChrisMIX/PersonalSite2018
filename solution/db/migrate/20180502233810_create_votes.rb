class CreateVotes < ActiveRecord::Migration

  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :candidate_id
    end
  end
end
