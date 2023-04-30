class CardsController < ApplicationController

  def keep_id
    Payjp.api_key = ENV["PAYJP_PUBLIC_KEY"] 
    customer = Payjp::Customer.create(
      description: 'test', 
      card: params[:token_id] 
    )
    card = Card.new(
      顧客idを保存するカラム名: customer.id,
      トークンidを保存するカラム名: params[:token_id],
      user_id: current_user.id
    )
  end

  def get_card_info
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPに秘密鍵を使ってアクセス
    card = Card.find_by(user_id: current_user.id) # cardsテーブルからレコードを取得

    customer = Payjp::Customer.retrieve(card.customer_id) # 顧客idを元に、顧客情報を取得
    @card = customer.cards.first # 登録したカード情報の取得
  end
end
