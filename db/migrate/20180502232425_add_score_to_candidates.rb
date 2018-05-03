class AddScoreToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :score, :integer
  end
end
