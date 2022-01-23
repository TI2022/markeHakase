class ReviewAnswer < ApplicationRecord
  belongs_to :staff
  belongs_to :review
end
