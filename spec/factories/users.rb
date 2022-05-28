FactoryBot.define do
  factory :user do
    shop_name             { Faker::Company.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 4, max_length: 126) + 'a0' }
    password_confirmation { password }
    last_name             { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
    last_name_kana        { Gimei.last.katakana }
    first_name_kana       { Gimei.first.katakana }
    postal_code           { Faker::Lorem.characters(number: 7, min_numeric: 7).insert(3, '-') }
    prefecture            { Gimei.address.prefecture.kanji }
    city                  { Gimei.address.city.kanji }
    town                  { Gimei.address.town.kanji }
    extended_address      { Faker::Address.secondary_address }
    phone_number          { Faker::PhoneNumber.cell_phone.delete('()-.').gsub(' ', '') }
    fax_number            { Faker::PhoneNumber.cell_phone.delete('()-.').gsub(' ', '') }
  end
end
