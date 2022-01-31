class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!
  before_action :set_month, only: :top

  def top
    if current_user && !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end
    @notifications = Notification.where(display_flag: true).order(created_at: "ASC")
    @reservations = Reservation.includes(:guest)
    @tops = Top.where(main_slide_flag: 1).order(image_order: :asc)
    @top1 = Top.find(1)
    @reserve_top = Top.find_by(reserve_image_flag: 1)
    @introduce_top = Top.find_by(introduction_image_flag: 1)
  end
  
  def notification
    @notifications = Notification.page(params[:page]).per(10).where(display_flag: true).order(created_at: "ASC")
  end

  def review_index
    @reviews = Review.includes(:reservation).page(params[:page]).per(10).order(created_at: "ASC")
    if @reviews.present?
      @review_total_score = @reviews.average(:total_score).round(1)
      @review_menu_score = @reviews.average(:menu_score).round(1)
      @review_customer_score = @reviews.average(:customer_score).round(1)
      @review_atmosphere_score = @reviews.average(:atmosphere_score).round(1)
    end
  end
end
