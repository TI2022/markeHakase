class PurchaseRecordsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @payments = Payment.all.order(created_at: "DESC")
  end

  def show
    @payment = Payment.find(params[:id])
    @orders = Order.where(payment_id: @payment.id)
    @event_orders = EventOrder.where(payment_id: @payment.id)
    @user = @payment.cart.user
    unshipped_orders = @orders.where(shipped_at: nil)
    unshipped_event_orders = @event_orders.where(shipped_at: nil)
    if !unshipped_orders.present? && !unshipped_event_orders.present?
      @payment.all_shipped_at = Time.current
      @payment.save
    elsif
      @payment.all_shipped_at == nil
    else
      @payment.all_shipped_at = nil
      @payment.save
    end
  end
end
