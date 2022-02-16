class StoresController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!, only: [:index, :show]

  def index
    @stores = Store.all.order(id: :asc)
  end

  def show
    
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "#{@store.name} の登録に成功しました"
      redirect_to stores_path(current_staff)
    else
      flash[:danger] = "新規店舗の登録に問題がありました"
      render :new
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      flash[:success] = "#{@store.name} の情報を更新しました。"
      redirect_to stores_path(current_staff)
    else
      flash[:danger] = "商品情報の編集に問題がありました"
      render :edit
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:success] = "#{@store.name} を削除しました。"
    redirect_to stores_path(current_staff)
  end
    
  private
    def store_params
      params.require(:store).permit(:name, :phone, :email, :line_id, :address, :description, :opening_time, :closing_time, :last_order_time, :non_business_day, :working_staff, :image, :google_map, :flagship_location)
    end
end
