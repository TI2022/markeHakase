class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipment_notification.subject
  #
  def shipment_notification(user, order)
    @user = user
    @order = order
    @item = order.item
    @payment = Payment.find(order.payment_id)
    mail to: user.email,
         subject: "【ゲンキノモト】商品発送のお知らせ"
  end
end
