class AddColumnStaffs < ActiveRecord::Migration[6.1]
  def change
    add_reference :staffs, :store, foreign_key: true, default: 1
    add_column :staffs, :authority, :integer
    add_column :staffs, :name, :string
    add_column :staffs, :kana, :string
    add_column :staffs, :phone, :string
    add_column :staffs, :sex, :integer
    add_column :staffs, :birthday, :datetime
    add_column :staffs, :address, :string
    add_column :staffs, :enter_date, :datetime
    add_column :staffs, :exit_date, :datetime
    add_column :staffs, :flag, :boolean, default: false
  end
end
