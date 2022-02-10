class Top < ApplicationRecord
  validates :image_text, presence: true
  validates :slide_number, presence: true, uniqueness: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  # CarrierWave 画像をURL経由で表示させる Top.image.url で表示可能
  mount_uploader :image, ImageUploader
end
