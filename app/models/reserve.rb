class Reserve < ApplicationRecord

  with_options presence: true do
    validates :reserve_on
    validates :total_price
  end

  belongs_to :customer
  belongs_to :address
  has_many :order_items, dependent: :destroy
end
