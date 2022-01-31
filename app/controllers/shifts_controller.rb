class ShiftsController < ApplicationController
  #スタッフは全てのアクションにアクセスできる
  skip_before_action :authenticate_user!
  before_action :set_shift, only: [:edit, :update]
  before_action :set_month, only: :index
  
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

end
