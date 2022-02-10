json.array! @reservations do |reservation|
  # reservation.cancel_flagがfalseの予約データのみイベントを作成
  if reservation.cancel_flag == 0
    json.id reservation.id
    if reservation.status == "completed"
      json.title "施術完了"
    else
      json.title reservation.title_for_staff
    end
    json.start reservation.start_time
    json.end reservation.end_time
    json.url edit_reserve_reservation_url(reservation.id)
  end
end