class AddStatusToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :status, :string
  end
end
