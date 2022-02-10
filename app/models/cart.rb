class Cart < ApplicationRecord
  # A user has only one cart. User > Cart > Orders (join table) > Items
  belongs_to :user
  # A cart has many orders.
  has_many :orders
  has_many :items, through: :orders # A cart has many items through orders

  has_many :event_orders
  has_many :events, through: :event_orders # A cart has many events through event_orders
  
  has_many :payments
end
