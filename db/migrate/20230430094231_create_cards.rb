class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :brand
      t.integer :exp_month
      t.integer :exp_year
      t.integer :last4
      t.string :name

      t.timestamps
    end
  end
end
