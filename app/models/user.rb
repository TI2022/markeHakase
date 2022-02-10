class User < ApplicationRecord
  belongs_to :store, optional: true
  has_many :reservations
  has_many :reviews, dependent: :destroy
  # A user has only one cart. User > Cart > Orders (join table) > Items
  # dependent: :destroyは未設定なので、Userが削除されてもCartは残る
  has_one :cart, dependent: :destroy
  include JpPrefecture
  jp_prefecture :prefecture_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  validates :name, presence: true, length: { maximum: 50 }
  validates :kana, length: { maximum: 50 }
  enum sex: { male: 0, female: 1, no_select: 2 }

  # line-login関連ここから
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
  # line-login関連ここまで

  # 退会済みなら認証しない
  def active_for_authentication?
    super && (self.flag == false)
  end
end
