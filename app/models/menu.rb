class Menu < ApplicationRecord
  validates :category, presence: true
  validates :category_order, presence: true
  validates :category_title, presence: true
  validates :title_order, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :charge, presence: true
  validates :treatment_time, presence: true
  validates :course_number, presence: true, uniqueness: true
  # validates :image_number, presence: true, uniqueness: true
  # CarrierWave 画像をURL経由で表示させる Menu.image.url で表示可能
  mount_uploader :image, ImageUploader
end
