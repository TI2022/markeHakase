class OrdersController < ApplicationController
  skip_before_action :authenticate_staff!, only: [:create_item_order, :destroy_item_order]
  skip_before_action :authenticate_user!, only: [:ship_item_order, :cancel_ship_item_order, :index, :destroy]

  # カートが無い場合はカートを作成
  # User has_one Cart なので ".build_cart"を使う
  def create_item_order
    if !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    else
      cart = current_user.cart
    end
    order = cart.orders.build(order_params)
    order.item = Item.find(params[:item][:item_id])
    order.save
    #カートに追加した数だけ在庫を減らす
    item = order.item
    item.stock -= order.quantity
    item.save

    flash[:success] = "#{order.item.name} がカートに追加されました。"
    redirect_to carts_path(current_user)
  end

  def destroy_item_order
    order = Order.find(params[:format])
    # 注文削除の前にカート追加で減った注文数を戻す
    item = order.item
    item.stock += order.quantity
    item.save
    order.destroy
    flash[:success] = "#{order.item.name} がカートから削除されました。"
    redirect_to carts_path(current_user)
  end

  def ship_item_order
    order = Order.find(params[:format])
    order.shipped_at = Time.current
    order.save
    
    # 発送完了時にメールを送信する機能
    user = User.find(order.cart.user.id)
    OrderMailer.shipment_notification(user, order).deliver_now

    redirect_to purchase_record_path(order.payment_id)
  end

  def cancel_ship_item_order
    order = Order.find(params[:format])
    order.shipped_at = nil
    order.save
    redirect_to purchase_record_path(order.payment_id)
  end

  def index
    @orders = Order.where(paid_at: nil).order(created_at: "DESC")
  end

  def destroy
    @order = Order.find(params[:id])
    # 注文削除の前にカート追加で減った注文数を戻す
    item = Item.find(@order.item_id)
    item.stock += @order.quantity
    item.save
    @order.destroy
    flash[:success] = "商品注文別ID: #{@order.id} を削除しました。"
    redirect_to orders_path(current_staff)
  end

  private
    def order_params
      params.permit(:item_id, :quantity, :paid_at, :payment_id, :adult_count, :child_count, :shipped_at)
    end

end
