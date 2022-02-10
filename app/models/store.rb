class Store < ApplicationRecord
  has_many :users
  has_many :staffs
  # CarrierWave 画像をURL経由で表示させる Store.image.url で表示可能
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, length: { maximum: 15 }
  validates :email, length: { maximum: 50 }
  validates :line_id, length: { maximum: 50 }
  validates :address, length: { maximum: 100 }
  validates :working_staff, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
end
