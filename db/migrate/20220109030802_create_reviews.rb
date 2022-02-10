class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :total_score # 全体
      t.integer :menu_score # 料金、メニュー
      t.integer :customer_score # 接客
      t.integer :atmosphere_score # 店の雰囲気
      t.boolean :review_exists, default: false, null: false

      t.timestamps
    end
  end
end
