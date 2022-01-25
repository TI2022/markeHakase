class ShiftsController < ApplicationController
  #スタッフは全てのアクションにアクセスできる
  skip_before_action :authenticate_user!
  before_action :set_shift, only: [:edit, :update]
  before_action :set_one_month, only: :index
  

  def index
  end

  def edit
  end

  def update
    if @shift.update(shift_params)
      flash[:success] = "情報を更新しました"
      redirect_to shifts_path
    else
      flash[:danger] = "編集に問題がありました"
      render :edit
    end
  end

  private
    def shift_params
      params.require(:shift).permit(:working_day, :working_staff, :store_id)
    end

    def set_shift
      @shift = Shift.find(params[:id])
    end

    def set_one_month
      $days_of_the_week = %w{日 月 火 水 木 金 土}
      @first_day = params[:date].nil? ?
      Date.current.beginning_of_month : params[:date].to_date
      @last_day = @first_day.end_of_month
      one_month = [*@first_day..@last_day] 
      @shifts = Shift.where(working_day: @first_day..@last_day).order(:working_day)
      unless one_month.count == @shifts.count # それぞれの件数（日数）が一致するか評価します。
        ActiveRecord::Base.transaction do # トランザクションを開始します。
          # 繰り返し処理により、1ヶ月分のデータを生成します。
          one_month.each { |day| @shifts.create!(working_day: day) }
        end
        @shifts = Shift.where(working_day: @first_day..@last_day).order(:working_day)
      end

    rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
      redirect_to root_url
    end
end
