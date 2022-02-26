class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!

  def index
    @reviews = Review.includes(:reservation).where(user_id: current_user.id).page(params[:page]).per(10).order(updated_at: "DESC")
    if @reviews.present?
      @review_total_score = @reviews.average(:total_score).round(1)
      @review_menu_score = @reviews.average(:menu_score).round(1)
      @review_customer_score = @reviews.average(:customer_score).round(1)
      @review_atmosphere_score = @reviews.average(:atmosphere_score).round(1)
    end
    # reservations/:reservation_id/reviews/:id
    # reservation_idがないとindexに遷移できないので、とりあえず入れる
    @reservation_id = Reservation.find(params[:reservation_id])
  end

  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new
  end
  
  def create
    reservation = Reservation.find(params[:reservation_id])
    review = Review.new(review_params)
    review.user_id = current_user.id # 親子関係で必須項目
    review.reservation_id = params[:reservation_id] # 親子関係で必須項目
    if review.save
      reservation.review_id = review.id
      reservation.is_reviewed = true
      reservation.save

      # 口コミ投稿完了時にメールを送信する機能/34行目 コメントアウトを外したら有効
      ReviewMailer.review_notification(current_user, reservation, review).deliver_now

      flash[:success] = "口コミの投稿に成功しました。"
      redirect_to reservation_reviews_url
    else
      flash[:danger] = "口コミの投稿に失敗しました。入力項目を確認してください。"
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
      flash[:success] = "口コミの編集に成功しました。"
      redirect_to reservation_reviews_url
    else
      flash[:danger] = "口コミの更新に失敗しました。入力項目を確認してください。"
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    reservation = review.reservation
    reservation.is_reviewed = false
    reservation.review_id = nil
    reservation.is_review_answered = false
    reservation.review_answer_id = nil
    reservation.save
    review.destroy
    flash[:success] = "口コミを削除しました。"
    redirect_to users_account_url
  end
  
  def header_reviews
    @reviews = Review.includes(:reservation).page(params[:page]).per(10).order(updated_at: "DESC")
    if @reviews.present?
      @review_total_score = @reviews.average(:total_score).round(1)
      @review_menu_score = @reviews.average(:menu_score).round(1)
      @review_customer_score = @reviews.average(:customer_score).round(1)
      @review_atmosphere_score = @reviews.average(:atmosphere_score).round(1)
    end
  end

  def header_reviews_destroy
    review = Review.find(params[:format])
    reservation = review.reservation
    reservation.is_reviewed = false
    reservation.review_id = nil
    reservation.is_review_answered = false
    reservation.review_answer_id = nil
    reservation.save
    review.destroy
    flash[:success] = "口コミを削除しました。"
    redirect_to header_reviews_url
  end

  private
    def review_params
      params.require(:review).permit(:reservation_id, :user_id, :title, :content, :total_score, :menu_score, :customer_score, :atmosphere_score, :review_exists, :nickname, :is_answered, :review_answer_id)
    end

end
