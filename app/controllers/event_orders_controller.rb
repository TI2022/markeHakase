class EventOrdersController < ApplicationController
  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_user!, only: [:ship_event_order, :cancel_ship_event_order, :index, :destroy]

  def create_event_order
    if !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    else
      cart = current_user.cart
    end
    event_order = cart.event_orders.build(event_order_params)
    event_order.event = Event.find(params[:event][:event_id])
    event_order.save
    #購入した数だけ在庫を減らす
    event = event_order.event
    event.stock -= event_order.quantity
    event.save

    flash[:success] = "#{event_order.event.title} がカートに追加されました。"
    redirect_to carts_path(current_user)
  end

  def destroy_event_order
    event_order = EventOrder.find(params[:format])
    event = event_order.event
    event.stock += event_order.quantity
    event.save
    event_order.destroy
    flash[:success] = "#{event_order.event.title} がカートから削除されました。"
    redirect_to carts_path(current_user)
  end

  def ship_event_order
    event_order = EventOrder.find(params[:format])
    event_order.update(event_order_params)

    # 発送完了時にメールを送信する機能/39, 40 コメントアウトを外したら有効
    user = User.find(event_order.cart.user.id)
    EventOrderMailer.shipment_notification(user, event_order).deliver_now

    redirect_to purchase_record_path(event_order.payment_id)
  end

  def cancel_ship_event_order
    event_order = EventOrder.find(params[:format])
    event_order.shipped_at = nil
    event_order.shipping_company = nil
    event_order.tracking_number = nil
    event_order.update(event_order_params)
    redirect_to purchase_record_path(event_order.payment_id)
  end

  def index
    @event_orders = EventOrder.where(paid_at: nil).order(created_at: "DESC")
  end

  def destroy
    @event_order = EventOrder.find(params[:id])
    # 注文削除の前にカート追加で減った注文数を戻す
    event = Event.find(@event_order.event_id)
    event.stock += @event_order.quantity
    event.save
    @event_order.destroy
    flash[:success] = "商品注文別ID: #{@event_order.id} を削除しました。"
    redirect_to event_orders_path(current_staff)
  end

  private
    def event_order_params
      params.permit(:event_id, :quantity, :paid_at, :payment_id, :adult_count, :child_count, :shipped_at, :shipping_company, :tracking_number)
    end
end
