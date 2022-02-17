class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!, only: [:index, :show]

  def index
    @tops = Top.all
    @top1 = Top.find(1)
  end

  def show
    @top = Top.find(params[:id])
  end

  def new
    @top = Top.new
  end

  def create
    @top = Top.new(top_params)
    if @top.save
      flash[:success] = "#{@top.image_text} の登録に成功しました"
      redirect_to tops_path(current_staff)
    else
      flash[:danger] = "新規登録に問題がありました"
      render :new
    end
  end

  def edit
    @top = Top.find(params[:id])
  end

  def update
    @top = Top.find(params[:id])
    if @top.update(top_params)
      flash[:success] = "#{@top.image_text} の情報を更新しました。"
      redirect_to tops_path(current_staff)
    else
      flash[:danger] = "編集に問題がありました"
      render :edit
    end
  end
    
  private
    def top_params
      params.require(:top).permit(:reserve_title,
                                  :reserve_text,
                                  :reserve_text_caution,
                                  :reserve_text2,
                                  :reserve_text2_caution,
                                  :reserve_comfirm_title,
                                  :reserve_comfirm_text,
                                  :calendar_title,
                                  :introduction_title,
                                  :introduction_text,
                                  :introduction_address,
                                  :introduction_time,
                                  :introduction_holiday,
                                  :introduction_tel,
                                  :slide_number,
                                  :image_order,
                                  :image_text,
                                  :slide_image_count,
                                  :introduction_image_count,
                                  :main_slide_flag,
                                  :reserve_image_flag,
                                  :introduction_image_flag,
                                  :store_id,
                                  :image)
    end
end
