class AddColumnToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :is_reviewed, :boolean, default: false
    add_column :reservations, :review_id, :integer
    add_column :reservations, :is_review_answered, :boolean, default: false
    add_column :reservations, :review_answer_id, :integer

  end
end
