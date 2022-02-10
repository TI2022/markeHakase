class Event < ApplicationRecord
  has_many :event_orders
  validates :title, presence: true, length: { maximum: 300 }
  validates :price, presence: true
  # CarrierWave 画像をURL経由で表示させる Event.image.url で表示可能
  mount_uploader :image, ImageUploader
end
