class Product < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :variety
    validates :rank
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0 }
    validates :stock, numericality: {only_integer: true, greater_than_or_equal_to: 1 }
    validates :postage, numericality: {only_integer: true, greater_than_or_equal_to: 0 }
  end

  validates :suspended, inclusion: { in: [true, false] }
  validates_presence_of :user

  has_many :carts, through: :cart_items
  has_many :cart_items, dependent: :destroy
  belongs_to :user, inverse_of: :products
end
