class ReviewAnswersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.find(params[:format])
    @review_answer = ReviewAnswer.new
    
  end

  def create
    review_answer = ReviewAnswer.new(review_answer_params)
    if review_answer.save
      review = review_answer.review
      review.is_answered = true
      review.review_answer_id = review_answer.id
      review.save
      flash[:success] = "投稿に成功しました"
      redirect_to header_reviews_path
    else
      flash[:danger] = "投稿に失敗しました、入力項目を確認してください。"
      render :new
    end
  end

  def edit
    
    @review = Review.find(params[:format])
    @review_answer = ReviewAnswer.find(@review.review_answer_id)
  end

  def update
    @review = Review.find(params[:format])
    @review_answer = @review.review_answer.first
  end

  def destroy
    @review_answer = ReviewAnswer.find(params[:id])
    if @review_answer.destroy
      redirect_to header_reviews_path
      flash[:success] = "レビューへの投稿を削除いたしました。"
    end
  end

  private
    def review_answer_params
      params.require(:review_answer).permit(:content, :reservation_id, :staff_id)
    end
end
