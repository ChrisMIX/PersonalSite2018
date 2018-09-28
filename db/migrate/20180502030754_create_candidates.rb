class CreateCandidates < ActiveRecord::Migration

  def change
    create_table :candidates do |t|
      t.string :name
      t.string :image_url
      t.string :title
      t.text :bio

      t.timestamps null: false
    end
  end
end

