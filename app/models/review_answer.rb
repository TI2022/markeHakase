class ReviewAnswer < ApplicationRecord
  belongs_to :review
  belongs_to :reservation, through: :review
end
