class UsersController < ApplicationController
  # indexとshowはスタッフのみのログインで可能
  skip_before_action :authenticate_user!, only: [:index, :search, :show, :admin_new, :admin_create, :admin_edit, :admin_update, :admin_destroy]
  skip_before_action :authenticate_staff!, only: [:account] # 抜けていたので追記しました
  before_action :set_q, only: [:index, :search]

  def index
    @users = User.all.page(params[:page]).per(10).order(id: "ASC")
  end

  def search
    @results = @q.result
  end

  def show
    @user = User.find(params[:format])
    @store = Store.find(@user.store_id)
  end

  def admin_new
    @user = User.new
  end

  def admin_create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} さんが新規登録されました"
      redirect_to users_index_path(current_user)
    else
      flash[:danger] = "新規お客様の登録に問題がありました"
      render :admin_new
    end
  end

  def admin_edit
    @user = User.find(params[:format])
  end

  def admin_update
    @user = User.find(params[:format])
    if @user.update!(user_params)
      flash[:success] = "#{@user.name} さんの情報を更新しました。"
      redirect_to users_index_path(current_staff)
    else
      flash[:danger] = "お客様情報の編集に問題がありました"
      render :admin_edit
    end
  end

  def admin_destroy
    @user = User.find(params[:format])
    if @user.destroy
      flash[:success] = "#{@user.name} さんの情報を削除しました。"
    else
      flash[:danger] = "お客様情報の削除に問題がありました"
    end
    redirect_to users_index_path(current_staff)
  end

  def account
    if current_user && !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end
    @users = User.where(id: current_user.id)
    @reservations = Reservation.where(guest_id: current_user.id).where(cancel_flag: false).where.not(status: 3)
    @completed_reservations= Reservation.where(guest_id: current_user.id).where(cancel_flag: false).where(status: 3)
    # @payments = @q.result.page(params[:page]).per(5).order(id: "DESC") if current_user.cart.payments.present?
  end

  def out
    user = current_user
    if user.update(flag: true, exit_date: Time.now)
      reset_session # データをリセットする
      flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :kana, :sex, :birthday, :store_id, :postal_code, :prefecture_code, :city, :street, :other_address, :password, :password_confirmation)
  end
  
  def set_q
    @q = User.ransack(params[:q])
  end
end
