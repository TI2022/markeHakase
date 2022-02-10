class Item < ApplicationRecord
  # A user has only one cart. User > Cart > Orders (join table) > Items
  has_many :orders
  validates :name, presence: true, length: { maximum: 300 }
  validates :price, presence: true
  
  # CarrierWave 画像をURL経由で表示させる Item.image.url で表示可能
  mount_uploader :image, ImageUploader
end
