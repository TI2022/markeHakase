class AddColumnToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :is_reviewed, :boolean, default: false
    add_column :reservations, :review_id, :integer
  end
end
