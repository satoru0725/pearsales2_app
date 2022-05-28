class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code,
              format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-) or Eenter a number in half-width' }
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

  validates :phone_number, numericality: { only_integer: true }, length: { in: 10..11 }, if: proc { |address|
                                                                                               address.phone_number.present?
                                                                                             }
  validates :fax_number, numericality: { only_integer: true }, length: { in: 10..11 }, if: proc { |address|
                                                                                             address.fax_number.present?
                                                                                           }

  belongs_to :customer
  has_many :reserves

  def full_address
    '〒' + postal_code + '　住所:' + prefecture + '' + city + '' + town + '' + extended_address + '　名前:' + last_name + '' + first_name
  end
end
