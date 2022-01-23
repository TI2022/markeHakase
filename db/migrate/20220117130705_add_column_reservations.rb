class AddColumnReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :is_review_exists, :integer, default: 1

  end
end
