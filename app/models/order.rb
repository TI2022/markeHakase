class Order < ApplicationRecord
  # This is a join table between Cart and Item.
  # A user has only one cart. User > Cart > Orders (join table) > Items
  belongs_to :cart
  belongs_to :item

  enum shipping_company: {
    未設定: 0,
    ヤマト運輸: 1,
    佐川急便: 2,
    日本郵便: 3,
    その他: 4
  }

end
