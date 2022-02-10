class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :store_id, default: 1
      t.string :name
      t.string :description
      t.integer :price
      t.integer :stock
      t.datetime :purchasing_date
      t.string :image # image 必ず一番下にしないと画像が読めない

      t.timestamps
    end
  end
end
