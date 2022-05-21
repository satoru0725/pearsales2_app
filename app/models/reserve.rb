class Reserve < ApplicationRecord
  belongs_to :customer
  belongs_to :address
  has_many :order_items, dependent: :destroy
end
