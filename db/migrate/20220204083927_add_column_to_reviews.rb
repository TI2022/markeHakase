class AddColumnToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :nickname, :string
    add_column :reviews, :is_review_answered, :boolean, default: false
    add_column :reviews, :review_answer_id, :integer
  end
end
