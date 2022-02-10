# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/shipment_notification
  def shipment_notification
    OrderMailer.shipment_notification
  end

end
