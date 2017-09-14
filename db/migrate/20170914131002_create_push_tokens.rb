class CreatePushTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :push_tokens do |t|
      t.string :value

      t.timestamps
    end
  end
end
