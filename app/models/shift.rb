class Shift < ApplicationRecord
  validates :working_staff, presence: true
  validates :working_day, presence: true
end
