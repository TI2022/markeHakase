class CreateTops < ActiveRecord::Migration[6.1]
  def change
    create_table :tops do |t|
      t.string :reserve_title
      t.string :reserve_text
      t.string :reserve_text_caution
      t.string :reserve_text2
      t.string :reserve_text2_caution
      t.string :reserve_comfirm_title
      t.string :reserve_comfirm_text
      t.string :calendar_title
      t.string :introduction_title
      t.string :introduction_text
      t.string :introduction_address
      t.string :introduction_time
      t.string :introduction_holiday
      t.string :introduction_tel
      t.string :image_text
      t.integer :image_order
      t.integer :slide_number
      t.integer :slide_image_count # メインスライドイメージ数
      t.integer :introduction_image_count # 紹介スライドイメージ数
      t.integer :main_slide_flag, default: 0
      t.integer :introduction_image_flag, default: 0
      t.integer :reserve_image_flag, default: 0
      t.integer :store_id, default: 1
      t.string :image # image 必ず一番下にしないと画像が読めない

      t.timestamps
    end
  end
end
