class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!

  def top
    if current_user && !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end
    @notifications = Notification.where(display_flag: true).order(created_at: "ASC")
    @reservations = Reservation.includes(:guest)
  end
  
  def notification
    @notifications = Notification.page(params[:page]).per(10).where(display_flag: true).order(created_at: "ASC")
  end
end
