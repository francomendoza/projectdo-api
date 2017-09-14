class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.datetime :datetime
      t.string :status
      t.datetime :acknowledged_at
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
