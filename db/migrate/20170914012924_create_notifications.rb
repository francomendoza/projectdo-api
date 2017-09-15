class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :body
      t.datetime :datetime
      t.string :status
      t.datetime :acknowledged_at
      t.string :job_id
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
