class UserMailer < ApplicationMailer
  #申込したゲストへのメール
  def request_reservation(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email,
         subject: "ゲンキノモト予約申込みメール")
  end

  #スタッフへのメール
  def request_reservation_staff(user, reservation)
    @user = user
    @reservation = reservation
    # mail(to: ENV["GMAIL_USERNAME"],
    mail(to: "motorsports46animals@gmail.com",#テスト用アドレスなので、本番では変更要(envファイルにて再設定してください）。
         subject: "予約申込みメール")
  end

  #スタッフへのメール
  def reservation_confirm(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email,
         subject: "ゲンキノモト予約確定メール")
  end
end
