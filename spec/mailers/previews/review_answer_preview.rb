# Preview all emails at http://localhost:3000/rails/mailers/review_answer
class ReviewAnswerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/review_answer/review_answer_notification
  def review_answer_notification
    ReviewAnswerMailer.review_answer_notification
  end

end
