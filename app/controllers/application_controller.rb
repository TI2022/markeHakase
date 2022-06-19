class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :authenticate_staff!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # for friendly-forwarding
  before_action :store_user_location!, if: :storable_location?

  def after_sign_in_path_for(resource)
    case resource
    when User
      users_account_path
    when Staff
      staffs_account_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_user
    @user = User.find(params[:id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to(root_url)
    end
  end
  
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    unless current_user.id === @reservation.guest_id
      flash[:danger] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
  end

  def set_month
    $days_of_the_week = %w{日 月 火 水 木 金 土}
    now = Date.current
    @first_day = params[:date].nil? ? now.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    current_month = [*@first_day..@last_day]
    @next_first_day = now.next_month.beginning_of_month
    @next_last_day = @next_first_day.end_of_month
    @shifts = Shift.where(working_day: @first_day..@last_day).order(:working_day)
    next_month = [*@next_first_day..@next_last_day]
    @next_shifts = Shift.where(working_day: @next_first_day..@next_last_day).order(:working_day)
    unless current_month.count == @shifts.count
      ActiveRecord::Base.transaction do
        current_month.each { |day| @shifts.create!(working_day: day) }
      end
      @shifts = Shift.where(working_day: @first_day..@last_day).order(:working_day)
    end
    unless next_month.count == @next_shifts.count
      ActiveRecord::Base.transaction do
        next_month.each { |n_day| @next_shifts.create!(working_day: n_day) }
      end
      @next_shifts = Shift.where(working_day: @next_first_day..@next_last_day).order(:working_day)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :enter_date])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :store_id,
        :name,
        :kana,
        :phone,
        :sex,
        :birthday,
        :postal_code,
        :prefecture_code,
        :city,
        :street,
        :other_address,
        :exit_date
        ])
    end

    private
    # for friendly-forwarding
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end
    # for friendly-forwarding
    def store_user_location!
      store_location_for(:user, request.fullpath)
    end
end
