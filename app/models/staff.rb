class Staff < ApplicationRecord
  has_many :notifications
  has_many :reservations
  has_many :review_answer, dependent: :destroy
  belongs_to :store, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
end
