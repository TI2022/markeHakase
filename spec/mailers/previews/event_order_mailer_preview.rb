# Preview all emails at http://localhost:3000/rails/mailers/event_order_mailer
class EventOrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_order_mailer/shipment_notification
  def shipment_notification
    EventOrderMailer.shipment_notification
  end

end
