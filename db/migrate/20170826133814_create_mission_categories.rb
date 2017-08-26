class CreateMissionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :mission_categories do |t|
      t.references :mission, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
