class ReviewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.review_notification.subject
  #
  def review_notification(current_user, reservation, review)
    @user = current_user
    @reservation = reservation
    @review = review
    @staff = Staff.find(@reservation.staff_id)
    mail to: @staff.email,
    subject: "【ゲンキノモト】新規口コミが投稿されました"
  end
end
