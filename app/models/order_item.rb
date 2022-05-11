class OrderItem < ApplicationRecord

  belongs_to :product
  belongs_to :reserve
end
