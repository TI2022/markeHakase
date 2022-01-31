class ApplicationMailer < ActionMailer::Base
  #送信元のメールアドレスを設定（envファイル作成要）
  # default from: "noreply@genkinomoto.com" #テスト用アドレスなので、本番では変更要(envファイルにて再設定してください）。
  default from: ENV["GMAIL_USERNAME"]
  layout 'mailer'
end
