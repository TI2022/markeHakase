class ReservationValidator < ActiveModel::EachValidator
  # start_timeとend_timeのデータを元に同時刻に予約が重複しないようにバリデーションをかける
  # record：検証対象のモデルオブジェクト（Reservationモデル）
  # attribute：検証対象のフィールド名（カラム名）
  # value：検証対象の値
  def validate_each(record, attribute, value)
    # 新規登録する期間
    new_start_time = record.start_time
    new_end_time = record.end_time

    return unless new_start_time.present? && new_end_time.present?

    this_b_day = new_start_time.beginning_of_day
    this_e_day = this_b_day.end_of_day
    this_all_day = [this_b_day..this_e_day]

    today_reservation = Reservation.where(start_time: this_all_day)


    # 重複する期間を検索(編集時は自期間を除いて検索)
    # 同一ユーザーでなければ同時刻でも登録できる (record.guest_idで判定)(例：同一idだとスルー)
    # cancel_flagが1のデータは重複可能にする(例：1（キャンセル）ならバリデーションをスルー)
    if record.id.present? # 編集時は同時刻でもバリデーションにかからない
      not_own_periods = today_reservation.where('cancel_flag IN (?) AND guest_id IN (?) AND id NOT IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.guest_id, record.id, new_end_time, new_start_time)
    else
      not_own_periods = today_reservation.where('cancel_flag IN (?) AND guest_id IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.guest_id, new_end_time, new_start_time)
    end

    # 同時刻予約がある期間を検索
    if record.id.present?
      working_staff = today_reservation.where('cancel_flag IN (?) AND id NOT IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.id, new_end_time, new_start_time)
    else
      working_staff = today_reservation.where('cancel_flag IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, new_end_time, new_start_time)
    end

    # 予約制限がある期間を検索
    if record.id.present?
      validate_time = today_reservation.where('validate_flag NOT IN (?) AND cancel_flag IN (?) AND id NOT IN (?) AND start_time < ? AND end_time > ?', record.validate_flag, record.cancel_flag, record.id, new_end_time, new_start_time)
    else
      validate_time = today_reservation.where('validate_flag NOT IN (?) AND cancel_flag IN (?) AND start_time < ? AND end_time > ?', record.validate_flag, record.cancel_flag, new_end_time, new_start_time)
    end

    day = record.start_time
    shift = Shift.find_by(working_day: day)

    if working_staff.count >= shift.working_staff # 同時刻予約がある期間 >= その日の稼働スタッフ数
      record.errors.add(attribute, 'エラー、すでに予約が埋まっています。') if working_staff.count >= shift.working_staff # 同時刻予約はスタッフ稼働人数まで
    end
    if not_own_periods.present?
      record.errors.add(attribute, 'エラー、予約時間に重複があります。') if not_own_periods.present?
    end
    if validate_time.present?
      record.errors.add(attribute, 'エラー、この時間は予約ができません。') if validate_time.present?
    end

  end
end
