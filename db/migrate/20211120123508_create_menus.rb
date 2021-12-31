class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :category
      t.integer :category_order
      t.string :category_title
      t.integer :title_order
      t.string :title
      t.string :full_title
      t.integer :charge
      t.string :description
      t.integer :treatment_time
      t.integer :course_number, default: 0
      t.integer :store_id, default: 1
      t.integer :image_number
      t.string :image # image 必ず一番下にしないと画像が読めない

      t.timestamps
    end
  end
end
