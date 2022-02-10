class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :body
      t.boolean :display_flag, default: true
      t.references :staff, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
