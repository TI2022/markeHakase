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
      t.integer :course_number
      
      t.integer :select_tab_number # 予約画面で表示するタブ （例： 1:フットケア 2:ボディケア ）
      t.string :select_tab_name # 予約画面で表示するタブ 選択タブに表示したい名前を指定できる

      t.integer :image_flag, default: 0 #施術メニューに「画像」を表示するか選べる 0:表示 1:非表示
      t.integer :menu_flag, default: 0 #施術メニューに「メニュー」を表示するか選べる 0:表示 1:非表示
      t.integer :reserve_flag, default: 0 #予約画面に「メニュー」を表示するか選べる 0:表示 1:非表示

      t.integer :topping_number # 予約画面で使用

      t.integer :add_nail_number # 予約画面で使用
      t.integer :add_nail_count # 予約画面で使用

      t.integer :store_id, default: 1
      t.string :image # image 必ず一番下にしないと画像が読めない

      t.timestamps
    end
  end
end
