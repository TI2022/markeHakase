class CreateEventOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :event_orders do |t|
      t.references :cart, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :quantity
      t.datetime :paid_at
      t.integer :payment_id
      t.integer :adult_count
      t.integer :child_count
      t.datetime :shipped_at
      t.timestamps
    end
  end
end
