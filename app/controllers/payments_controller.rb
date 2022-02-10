class PaymentsController < ApplicationController
    skip_before_action :authenticate_staff!
    before_action :set_q, only: [:index, :search]

  def pay
    orders = current_user.cart.orders.where(paid_at: nil)
    event_orders = current_user.cart.event_orders.where(paid_at: nil)
    subtotal = 0
    
    orders.each do |order|
      subtotal += order.item.price*order.quantity
    end
    event_orders.each do |event_order|
      subtotal += event_order.event.price*event_order.quantity
    end

    # 5000円以上のお買い上げで送料無料
    if subtotal >= 5000 || subtotal == 0
      shipping_fee = 0
    else
      shipping_fee = 500
    end
    tax = ((subtotal+shipping_fee)*0.10).round
    total = subtotal+shipping_fee+tax

    payment = current_user.cart.payments.new
    payment.subtotal = subtotal
    payment.shipping_fee = shipping_fee
    payment.tax = tax
    payment.total = total
    payment.save

    Payjp.api_key = ENV["PAYJP_TEST_SECRET_KEY"]
    charge = Payjp::Charge.create(
    amount: total,
    card: params['payjp-token'],
    currency: 'jpy'
    )

    orders.each do |order|
      order.paid_at = Time.current
      order.payment_id = payment.id
      order.save
    end

    event_orders.each do |event_order|
      event_order.paid_at = Time.current
      event_order.payment_id = payment.id
      event_order.save
    end
    
    flash[:success] = "決済が完了しました。お買い上げ誠にありがとうございます。"
    redirect_to carts_path(current_user)
  end

  def index
    #@payments = current_user.cart.payments.order(id: "DESC")
    @payments = @q.result.page(params[:page]).per(5).order(id: "DESC") if current_user.cart.payments.present?
  end

  def show
    @payment = Payment.find(params[:id])
    @orders = Order.where(payment_id: @payment.id)
    @event_orders = EventOrder.where(payment_id: @payment.id)
  end

  private

    def set_q
      @q = current_user.cart.payments.ransack(params[:q]) if current_user.cart.payments.present?
    end
end
