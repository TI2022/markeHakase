class EventOrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_order_mailer.shipment_notification.subject
  #
  def shipment_notification(user, event_order)
    @user = user
    @event_order = event_order
    @event = event_order.event
    @payment = Payment.find(event_order.payment_id)
    mail to: user.email,
         subject: "【ゲンキノモト】チケット発送のお知らせ"
  end
end
