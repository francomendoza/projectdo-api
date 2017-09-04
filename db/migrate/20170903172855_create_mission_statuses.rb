class CreateMissionStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :mission_statuses do |t|
      t.string :description
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
