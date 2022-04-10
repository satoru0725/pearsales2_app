class Product < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :variety
    validates :rank
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0 }
    validates :stock
    validates :postage
  end

  validates :suspended, inclusion: { in: [true, false] }
  validates_presence_of :user

  has_many :customers, through: :orders
  belongs_to :user, inverse_of: :products
end
