class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :category
      t.integer :price
      t.integer :stock
      t.integer :adult_price
      t.integer :child_price
      t.string :description
      t.string :location
      t.date :first_date
      t.date :last_date
      t.time :start_time
      t.time :end_time
      t.time :start_time_alt
      t.time :end_time_alt
      t.integer :remaining_ticket_numbers
      t.boolean :status, default: false, null: false
      t.integer :owner_id
      t.integer :store_id, default: 1
      t.string :image # image 必ず一番下にしないと画像が読めない
      t.timestamps
    end
  end
end
