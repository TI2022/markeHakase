class OrdersController < ApplicationController
  #skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!

  # カートが無い場合はカートを作成
  # User has_one Cart なので ".build_cart"を使う
  def create
    if !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    else
      cart = current_user.cart
    end
    order = cart.orders.build(order_params)
    order.item = Item.find(params[:item][:item_id])
    order.save
    flash[:success] = "#{order.item.name} がカートに追加されました。"
    redirect_to carts_path(current_user)
  end

  def destroy
    @order = Order.find(params[:format])
    @order.destroy
    flash[:success] = "#{@order.item.name} がカートから削除されました。"
    redirect_to carts_path(current_user)
  end

  private
    def order_params
      params.permit(:quantity, :item_id, :sub_total, :shipping_fee, :handling_fee, :tax, :grand_total)
    end

end
