class CreateReviewAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :review_answers do |t|
      t.references :reservation, null: false, foreign_key: true
      t.integer :review_id
      t.integer :staff_id
      t.string :content

      t.timestamps
    end
  end
end
