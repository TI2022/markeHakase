# カレンダー用に全ての予約枠を形成する
json.array! @reservations do |reservation|
  # reservation.cancel_flagが0の予約データのみイベントを作成
  if reservation.cancel_flag == 0
    json.id reservation.id
    # ログインしていないユーザーは全て×、ログインしているユーザーで、自分の予約以外は全て×
    if user_signed_in?
      if current_user.id == reservation.guest_id
        if reservation.status == "completed"
          json.title "施術完了"
        else
          json.title reservation.title_for_guest
        end
      else
        json.title "×"
      end
    else
      json.title "×"
    end
    json.start reservation.start_time
    if user_signed_in?
      if current_user.id == reservation.guest_id
        # ログインしたユーザーが自分の予約を確認する時だけカレンダーの表示をインターバルを抜いた時間で終了時間を表示
        json.end (reservation.start_time + (reservation.treatment_time_menu * 60))
      else
        json.end reservation.end_time
      end
    else
      json.end reservation.end_time
    end
    
    # ログインしているユーザーの場合、自分の予約詳細に遷移できるURLを生成する
    if user_signed_in?
      if current_user.id == reservation.guest_id
        json.url reservation_url(reservation.id)
      end
    end
  end
end
