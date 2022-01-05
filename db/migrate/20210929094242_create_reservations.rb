class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :store_id, default: 1
      t.datetime :start_time
      t.datetime :end_time
      t.string :title_for_guest
      t.string :title_for_staff
      t.integer :course, default: 0
      t.integer :status, default: 0
      t.string :comment
      t.integer :staff_id
      t.integer :guest_id
      t.datetime :reservation_time
      t.integer :holiday_flag, default: 0
      t.integer :cancel_flag, default: 0
      t.string :treatment_menu
      t.integer :treatment_time_menu
      t.integer :charge_menu # メニュー値段
      t.integer :topping_menu # トッピングメニュー種類
      t.integer :add_nail_count # 巻き爪補正本数
      t.integer :full_treatment_time_menu # 追加を含めた施術時間
      t.integer :full_charge_menu # 追加を含めたメニュー値段

      t.timestamps
    end
  end
end
