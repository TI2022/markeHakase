class ReservationValidator < ActiveModel::EachValidator
  # start_timeとend_timeのデータを元に同時刻に予約が重複しないようにバリデーションをかける
  # record：検証対象のモデルオブジェクト
  # attribute：検証対象のフィールド名
  # value：検証対象の値
  def validate_each(record, attribute, value)
    # 新規登録する期間
    new_start_time = record.start_time
    new_end_time = record.end_time

    return unless new_start_time.present? && new_end_time.present?

    # 重複する期間を検索(編集時は自期間を除いて検索)
    # 編集時は同時刻でもバリデーションにかからない
    # 同一ユーザーでなければ同時刻でも登録できる (record.guest_idで判定)(例：同一idだとスルー)
    # cancel_flagが1のデータは重複可能にする(例：1（キャンセル）ならバリデーションをスルー)
    if record.id.present?
      not_own_periods = Reservation.where('cancel_flag IN (?) AND guest_id IN (?) AND id NOT IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.guest_id, record.id, new_end_time, new_start_time)
    else
      not_own_periods = Reservation.where('cancel_flag IN (?) AND guest_id IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.guest_id, new_end_time, new_start_time)
    end

    # 同時刻予約がある期間を検索
    if record.id.present?
      working_staff = Reservation.where('cancel_flag IN (?) AND id NOT IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, record.id, new_end_time, new_start_time)
    else
      working_staff = Reservation.where('cancel_flag IN (?) AND start_time < ? AND end_time > ?', record.cancel_flag, new_end_time, new_start_time)
    end

    store = Store.find(record.store_id)

    if working_staff.count >= store.working_staff
      record.errors.add(attribute, "エラー、稼働スタッフは#{store.working_staff}人です。") if working_staff.count >= store.working_staff # 同時刻予約はスタッフ稼働人数まで
    elsif not_own_periods.present?
      record.errors.add(attribute, 'エラー、予約時間に重複があります。') if not_own_periods.present?
    end

  end
end
