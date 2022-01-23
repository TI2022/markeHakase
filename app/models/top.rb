class Top < ApplicationRecord
  validates :image_text, presence: true
  validates :slide_number, presence: true, uniqueness: true
  # CarrierWave 画像をURL経由で表示させる Top.image.url で表示可能
  mount_uploader :image, ImageUploader
end
