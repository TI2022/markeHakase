class CreateReviewAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :review_answers do |t|
      t.references :staff, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.string :staff_name
      t.text :content

      t.timestamps
    end
  end
end
