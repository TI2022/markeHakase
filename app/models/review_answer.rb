class ReviewAnswer < ApplicationRecord
  belongs_to :reservation, dependent: :destroy
end
