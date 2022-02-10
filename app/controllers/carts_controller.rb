class CartsController < ApplicationController
  skip_before_action :authenticate_staff!
  
  def show
    @orders = current_user.cart.orders.where(paid_at: nil)
    @event_orders = current_user.cart.event_orders.where(paid_at: nil)
    @subtotal = 0
    
    @orders.each do |order|
      @subtotal += order.item.price*order.quantity
    end
    @event_orders.each do |event_order|
      @subtotal += event_order.event.price*event_order.quantity
    end
    @tax = (@subtotal*0.10).round
    # 5000円以上のお買い上げで送料無料
    if @subtotal >= 5000 || @subtotal == 0
      @shipping_fee = 0
    else
      @shipping_fee = 500
    end
    @total = @subtotal+@tax+@shipping_fee
  end
end
