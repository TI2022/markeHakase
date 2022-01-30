class EventOrder < ApplicationRecord
  belongs_to :cart
  belongs_to :event

  enum shipping_company: {
    未設定: 0,
    ヤマト運輸: 1,
    佐川急便: 2,
    日本郵便: 3,
    その他: 4
  }

end
