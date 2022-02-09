class ReviewAnswersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.find(@reservation.review_id)
    @review_answer = ReviewAnswer.new
    @guest = @reservation.guest
    @staff = @reservation.staff
  end

  def create
    reservation = Reservation.find(params[:reservation_id])
    review = Review.find(reservation.review_id)
    review_answer = ReviewAnswer.new(review_answer_params)
    if review_answer.save
      reservation.review_answer_id = review_answer.id
      reservation.is_review_answered = true
      reservation.save
      review.review_answer_id = review_answer.id
      review.is_review_answered = true
      review.save

      # 口コミ返信完了時にメールを送信する機能/25行目 コメントアウトを外したら有効
      # ReviewAnswerMailer.review_answer_notification(current_staff, reservation, review).deliver_now

      flash[:success] = "口コミ返信の投稿に成功しました"
      redirect_to header_reviews_path
    else
      flash[:danger] = "口コミ返信の投稿に失敗しました。入力項目を確認してください。"
      render :new
    end
  end

  def edit
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.find(@reservation.review_id)
    @review_answer = ReviewAnswer.find(@reservation.review_answer_id)
    @guest = User.find(@reservation.guest_id)
    @staff = Staff.find(@reservation.staff_id)
  end

  def update
    reservation = Reservation.find(params[:reservation_id])
    review_answer = ReviewAnswer.find(reservation.review_answer_id)
    if review_answer.update(review_answer_params)
      flash[:success] = "口コミ返信の更新に成功しました"
      redirect_to header_reviews_path
    else
      flash[:danger] = "口コミ返信の更新に失敗しました。入力項目を確認してください。"
      render :edit
    end
  end

  def destroy
    reservation = Reservation.find(params[:reservation_id])
    review = Review.find(reservation.review_id)
    review_answer = ReviewAnswer.find(reservation.review_answer_id)
    if review_answer.destroy
      reservation.review_answer_id = nil
      reservation.is_review_answered = false
      reservation.save
      review.review_answer_id = nil
      review.is_review_answered = false
      review.save
      redirect_to header_reviews_path
      flash[:success] = "口コミ返信を削除しました。"
    end
  end

  private
    def review_answer_params
      params.require(:review_answer).permit(:reservation_id, :review_id, :staff_id, :user_id, :content)
    end
end
