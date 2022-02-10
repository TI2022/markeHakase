class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.integer "working_staff", default: 1
      t.date "working_day"
      t.integer :store_id, default: 1

      t.timestamps
    end
  end
end
