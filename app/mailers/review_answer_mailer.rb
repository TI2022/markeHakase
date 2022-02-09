class ReviewAnswerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_answer_mailer.review_answer_notification.subject
  #
  def review_answer_notification(current_staff, reservation, review)
    @staff = current_staff
    @reservation = reservation
    @review = review
    @guest = User.find(@reservation.guest_id)
    mail to: @guest.email,
    subject: "【ゲンキノモト】お客様の口コミに返信がされました"
  end
end
