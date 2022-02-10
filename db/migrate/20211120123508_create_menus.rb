class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :category
      t.integer :category_number, default: 0 # カテゴリー番号 フットケア：１ ボディケア：２ トッピング：３
      t.integer :category_order, default: 0 # カテゴリー順番 施術メニュー画面でカテゴリーの順番を並び替えたい時に使用
      t.string :category_title # カテゴリー内の小カテゴリー
      t.integer :category_title_number, default: 0 # カテゴリー内の小カテゴリー番号（ 初回：１、 通常：２、 スペシャル：３、 巻き爪補正：４、全身：５、 足ツボ：６、 DM：７）
      t.integer :category_title_order, default: 0 # category_titleの並び順の変更するために使用
      t.string :title
      t.string :full_title
      t.integer :charge, default: 0 # メニューの料金
      t.integer :original_charge, default: 0 # 割引メニューの元の値段
      t.string :description # メニューの説明
      t.integer :treatment_time, default: 0 # メニューの施術時間
      t.integer :course_number, default: 0 # 連番のコース番号（任意に変更可）
      t.integer :image_flag, default: 0 #施術メニューに「画像」を表示するか選べる 0:表示 1:非表示
      t.integer :menu_flag, default: 0 #施術メニューに「メニュー」を表示するか選べる 0:表示 1:非表示
      t.integer :reserve_flag, default: 0 #予約画面に表示する「メニュー」を選べる 0:表示 1:非表示
      t.integer :add_nail_count, default: 0
      t.integer :store_id, default: 1
      t.string :image # image 必ず一番下にしないと画像が読めない

      t.timestamps
    end
  end
end
