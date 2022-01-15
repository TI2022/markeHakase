class ReservationsController < ApplicationController
  skip_before_action :authenticate_user! #スタッフは全てのアクションにアクセスできる
  skip_before_action :authenticate_staff!, only: [:index, :show, :new, :create] #ログイン済みユーザーは{index,show,new,create}アクションのみアクセスできる
  before_action :set_reservations, only: [:index, :confirm_reservation, :management_new]
  before_action :set_reservation, only: [:show, :edit, :update, :edit_reserve, :update_reserve, :cancel_reserve, :destroy]
  before_action :set_menus, only: [:new, :edit_reserve, :update_reserve, :management_new]
  before_action :set_users, only: :management_new
  before_action :reservation_completed, only: [:index, :confirm_reservation] # :end_timeが現在時刻を過ぎているデータは:statusをcompleted(施術完了)にする
  before_action :set_q, only: [:reservation_management, :search]
  before_action :set_new, only: [:management_new, :new, :guest_reservation]
  before_action :set_staffs, only: [:management_new, :edit_reserve, :update_reserve]

  def reservation_management
    @search_reservations = @q.result
  end

  def search
    @search_reservations = @q.result
  end

  def management_new
  end

  def reservation_management_create
    @reservation = Reservation.new(reservation_params)
    menu = Menu.find_by(course_number: reservation_params[:course])
    if menu.present?
      menu_time = 60 * (menu.treatment_time + 10) # end_time登録の為に使用。インターバルタイムを10分追加した時間でend_timeを登録
      @reservation.treatment_menu = menu.full_title
      @reservation.treatment_time_menu = menu.treatment_time
      @reservation.charge_menu = menu.charge
      @reservation.apply_management!(menu_time)
    end
    if @reservation.save
      user = User.find(@reservation.guest_id)
      #申込したゲストへのメール
      # UserMailer.request_reservation(user, @reservation).deliver_now
      #スタッフへのメール
      # UserMailer.request_reservation_staff(user, @reservation).deliver_now
      redirect_to reservation_management_reservations_url, notice: "新規予約作成完了しました。"
    end
  end

  def index
  end

  def confirm_reservation
    @reservations_on_request = Reservation.on_request.from_today.includes(:guest)
    @reservations_on_reserve = Reservation.on_reserve.from_today.includes(:guest)
    respond_to do |format|
      format.html
      format.json { @reservations }
    end
  end

  def show
  end

  def new
    @first_time_guests = Reservation.where(guest_id: current_user.id).where(cancel_flag: 0)
    from  = Time.current.at_beginning_of_day
    to    = (from - 12.day).at_end_of_day
    @guests_within_two_weeks = Reservation.where(guest_id: current_user.id).where(cancel_flag: 0).where(end_time: from...to)
    menu = Menu.where(reserve_flag: 0) # 予約画面に表示するメニューはreserve_flag: 0のものだけ。
    @first_menu = menu.where(category_number: "1").where(category_title: "初回") # 初回メニュー
    @foot_menu = menu.where(category_number: "1")
                      .where.not(category_title_number: "1")
                      .where.not(category_title_number: "3")
                      .where.not(category_title_number: "4")
                      .where.not(category_title_number: "7") # フットケアメニュー(フットケアカテゴリーの中の初回、スペシャル、巻き爪補正、DMを抜いたメニュー)
    @body_menu = menu.where(category_number: "2") # ボディケアメニュー
    @topping_menu = menu.where.not(topping_number: nil) # トッピングメニュー
    @special_menu = menu.where(category_number: "1").where(category_title_number: "3") # ２ヶ月以内来店スペシャル割引メニュー
    @DM_menu = menu.where(category_number: "1").where(category_title_number: "7") # DMメニュー
    @add_nail_menu = menu.where(category_number: "1").where(category_title_number: "4") # 巻き爪補正メニュー
    # @add_nail_2 = menu.where(category_number: "1").where(treatment_time: 60..) # 巻き爪補正２本の時に選べるメニュー
  end

  def create
    @reservation = Reservation.new(reservation_params)
    add_nail = Menu.find_by(add_nail_count: reservation_params[:add_nail_count])
    menu = Menu.find_by(course_number: reservation_params[:course])
    topping_menu = Menu.find_by(course_number: reservation_params[:topping_menu][0]) unless reservation_params[:topping_menu].blank?
    if menu.present?
      if topping_menu.present?
        menu_time = 60 * (menu.treatment_time + topping_menu.treatment_time + 10) # end_time登録の為に使用。インターバルタイムを10分追加した時間でend_timeを登録
      else
        menu_time = 60 * (menu.treatment_time + 10) # end_time登録の為に使用。インターバルタイムを10分追加した時間でend_timeを登録
      end
      @reservation.treatment_menu = menu.full_title
      @reservation.treatment_time_menu = menu.treatment_time
      @reservation.charge_menu = menu.charge
      if topping_menu.present?                                                  #トッピングあり
        @reservation.full_charge_menu = menu.charge + topping_menu.charge 
      elsif add_nail.present?                                                   #トッピングなし、巻き爪補正あり
        @reservation.full_charge_menu = menu.charge + add_nail.charge
      elsif topping_menu.present? && add_nail.present?                           #トッピングあり、巻き爪補正あり
        @reservation.full_charge_menu = menu.charge + topping_menu.charge + add_nail.charge
      else                                                                        #トッピングなし、巻き爪補正なし
        @reservation.full_charge_menu = menu.charge
      end
      if topping_menu.present?
        @reservation.topping_menu = topping_menu.title
      end
      @reservation.apply!(menu_time)
    end
    if @reservation.save(context: :registration) #ゲストが新規予約する時だけ予約時間の範囲を限定する。
      user = User.find(@reservation.guest_id)
      #申込したゲストへのメール
      # UserMailer.request_reservation(user, @reservation).deliver_now
      #スタッフへのメール
      # UserMailer.request_reservation_staff(user, @reservation).deliver_now
      redirect_to reservations_url, notice: "お客様の仮予約が完了しました。承認されるまでお待ちください。"
    end
  end

  def edit
  end

  def update
    title_for_staff_comment = "予約確定 #{@reservation.guest.name}様 #{@reservation.treatment_menu}  #{@reservation.staff.name}"
    @reservation.update(status: :on_reserve, title_for_guest: "予約確定", title_for_staff: title_for_staff_comment)
    user = User.find(@reservation.guest_id)
    #ゲストへの予約確定メール
    # UserMailer.reservation_confirm(user, @reservation).deliver_now
    redirect_to confirm_reservation_reservations_url, notice: "予約確定をしました。"
  end

  def edit_reserve
  end

  def update_reserve
    if @reservation.update(reservation_params)
      menu = Menu.find_by(course_number: reservation_params[:course])
      if menu.present?
        menu_time = 60 * (menu.treatment_time + 10) # end_time登録の為に使用。インターバルタイムを10分追加した時間でend_timeを登録
        @reservation.treatment_menu = menu.full_title
        @reservation.treatment_time_menu = menu.treatment_time
        @reservation.charge_menu = menu.charge
        @reservation.apply_update!(menu_time)
      end
      if reservation_params[:cancel_flag] == "1"
        @reservation.update(status: :completed)
      else
        if reservation_params[:status] == "on_request"
          @reservation.update(
            title_for_guest: "仮予約",
            title_for_staff: "仮予約"
          )
        elsif reservation_params[:status] == "on_reserve"
          title_for_staff_comment = "予約確定 #{@reservation.guest.name}様  #{@reservation.treatment_menu}  #{@reservation.staff.name}"
          @reservation.update(
            title_for_guest: "予約確定",
            title_for_staff: title_for_staff_comment
          )
        end
      end
      redirect_to confirm_reservation_reservations_url, notice: "予約を編集しました。"
    else
      redirect_to edit_reserve_reservation_url(@reservation), notice: "編集に失敗しました。"
    end
  end

  def cancel_reserve
    # cancel_flagを1にする事で論理削除実施 & ステータスを3(completed施術完了)に切り替え
    @reservation.update(cancel_flag: 1, status: :completed)
    redirect_to reservation_management_reservations_url, notice: "予約をキャンセルしました。"
  end

  def destroy
    # cancel_flagを1にする事で論理削除実施 & ステータスを3(completed施術完了)に切り替え
    @reservation.destroy
    redirect_to reservation_management_reservations_url, notice: "予約を削除しました。"
  end

  private

    def reservation_params
      params.require(:reservation).permit(:start_time,
                                          :add_nail_count,
                                          :course,
                                          :add_menu,
                                          :comment,
                                          :status,
                                          :cancel_flag,
                                          :reservation_time,
                                          :staff_id,
                                          :guest_id,
                                          :store_id,
                                          :topping_menu
      )
    end

    def set_reservations
      @reservations = Reservation.includes(:guest)
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_menus
      @menus = Menu.all.order(course_number: :asc)
    end

    def set_users
      @users = User.all
    end

    def reservation_completed
      now = Time.current
      # .where('end_time > ?', now.yesterday.end_of_day)を入れる事で無駄なSQL（一日以上前のデータ）を流さないようにする
      reservations = Reservation.where('end_time > ?', now.yesterday.end_of_day).where('end_time < ?', now)
      reservations.each do |reservation|
        # :day_after_todayのバリデーションに引っかかるので、バリデーションの方を削除
        reservation.update(status: :completed) #ステータスを3(completed施術完了)に切り替え
      end
    end

    def set_q
      @q = Reservation.includes(:guest).ransack(params[:q])
    end

    def set_new
      @reservation = Reservation.new
    end

    def set_staffs
      @staffs = Staff.all
    end

end
