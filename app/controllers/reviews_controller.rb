class ReviewsController < ApplicationController
  skip_before_action :authenticate_staff!
  
  def new
    @reservation = Reservation.find_by(status: :completed)
    @review = Review.new
  end
  
  def create
    @reservation = Reservation.find(params[:reservation_id])
    @review = @reservation.reviews.build(review_params)
    @review.user_id = current_user.id
    # 1個の予約に対して、1個のレビューというvalidを作りたい
    # review_count = Review.where(reservation_id: params[:reservation_id]).where(user_id: current_user.id).count
    if @review.save
      redirect_to reservation_reviews_url
      flash[:success] = "投稿に成功しました。"
    else
      flash[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  def edit
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to reservation_reviews_url
      flash[:success] = "更新に成功しました。"
    else
      render :edit
      flash[:danger] = "更新に失敗しました。"
    end
  end

  def index
    @reservation = Reservation.find(params[:reservation_id])
    reviews = @reservation.reviews
    @reviews = reviews.page(params[:page]).per(10).order(created_at: "ASC")
    # @review_total_score = Review.where.not(total_score: nil)
    @review_total_score = @reviews.average(:total_score).round(1)
    @review_menu_score = @reviews.average(:menu_score).round(1)
    @review_customer_score = @reviews.average(:customer_score).round(1)
    @review_atmosphere_score = @reviews.average(:atmosphere_score).round(1)
  end

  # def show
  #   @reservation = Reservation.find(params[:id])
  #   @review = Review.find(params[:id])    
  # end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to users_account_url
      flash[:success] = "レビューを削除しました。"
    end
  end

  private
    def review_params
      params.require(:review).permit(:reservation_id, :title, :content, :total_score, :menu_score, :customer_score, :atmosphere_score, :review_exists)
    end

end
