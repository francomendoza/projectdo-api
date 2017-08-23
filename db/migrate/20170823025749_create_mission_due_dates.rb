class CreateMissionDueDates < ActiveRecord::Migration[5.1]
  def change
    create_table :mission_due_dates do |t|
      t.datetime :due_date
      t.string :option
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
