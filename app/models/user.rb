class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   with_options presence: true do
    validates :shop_name
    validates :phone_number, numericality: { only_integer: true }, length: { in: 10..11 }
    validates :postal_code,format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-) or Eenter a number in half-width' }
    validates :prefecture
    validates :city
    validates :town
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  has_many :products, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :products
end
