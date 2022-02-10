class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :kana, :string
    add_column :users, :phone, :string
    add_column :users, :sex, :integer
    add_column :users, :birthday, :datetime
    add_column :users, :enter_date, :datetime
    add_column :users, :exit_date, :datetime
    add_column :users, :flag, :boolean, default: false, null: false
    add_column :users, :cart_id, :integer
    add_reference :users, :store, foreign_key: true, default: 1
  end
end
