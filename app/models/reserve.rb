class Reserve < ApplicationRecord
  belongs_to :customer
  belongs_to :address
  has_many :products, through: :order_items
  has_many :order_items
end
