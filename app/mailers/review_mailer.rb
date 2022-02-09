class ReviewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.review_notification.subject
  #
  def review_notification
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
