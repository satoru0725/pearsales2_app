class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: false }
    validates :phone_number, numericality: { only_integer: true }, length: { in: 10..11 }
    validates :postal_code,
              format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-) or Eenter a number in half-width' }
    validates :prefecture
    validates :city
    validates :town
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }, on: :create

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :fax_number, numericality: { only_integer: true }, length: { in: 10..11 }, if: proc { |customer|
                                                                                             customer.fax_number.present?
                                                                                           }

  has_one :cart, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :reserves, dependent: :destroy
end
