class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :line_id
      t.string :address
      t.string :description
      t.time :opening_time
      t.time :closing_time
      t.time :last_order_time
      t.string :non_business_day
      t.integer :working_staff
      t.string :image # image 必ず一番下にしないと画像が読めない
      t.timestamps
    end
  end
end
