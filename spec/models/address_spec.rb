require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @customer = FactoryBot.create(:customer)
    @address = FactoryBot.build(:address)
    @address.customer_id = @customer.id
  end
  describe '配送先住所の新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が入力されると登録できる' do
        expect(@address).to be_valid
      end
      it 'extended_addressが存在しなくても登録できる' do
        @address.extended_address = ""
        expect(@address).to be_valid
      end
      it 'phone_numberが存在しなくても登録できる' do
        @address.phone_number = ""
        expect(@address).to be_valid
      end
      it 'fax_numberが存在しなくても登録できる' do
        @address.fax_number = ""
        expect(@address).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'last_nameが空では登録できない' do
        @address.last_name = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @address.first_name = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @address.last_name_kana = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @address.first_name_kana = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'postal_codeが空では登録できない' do
        @address.postal_code = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefectureが空では登録できない' do
        @address.prefecture = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @address.city = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end
      it 'townが空では登録できない' do
        @address.town = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("Town can't be blank")
      end
      it 'last_nameが半角では登録できない' do
        @address.last_name = Faker::Internet.username
        @address.valid?
        expect(@address.errors.full_messages).to include("Last name 全角文字を使用してください")
      end
      it 'first_nameが半角では登録できない' do
        @address.first_name = Faker::Internet.username
        @address.valid?
        expect(@address.errors.full_messages).to include("First name 全角文字を使用してください")
      end
      it 'last_name_kanaが半角では登録できない' do
        @address.last_name_kana = Faker::Internet.username
        @address.valid?
        expect(@address.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
      end
      it 'last_name_kanaが漢字では登録できない' do
        @address.last_name_kana = Gimei.last.kanji
        @address.valid?
        expect(@address.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
      end
      it 'first_name_kanaが半角では登録できない' do
        @address.first_name_kana = Faker::Internet.username
        @address.valid?
        expect(@address.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
      end
      it 'first_name_kanaが漢字では登録できない' do
        @address.first_name_kana = Gimei.first.kanji
        @address.valid?
        expect(@address.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
      end
      it 'postal_codeの4文字目に-(ハイフン)が存在しないと登録できない' do
        @address.postal_code = Faker::Lorem.characters(number:7, min_numeric: 7)
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'postal_codeが7文字以下だと登録できない' do
        @address.postal_code = Faker::Lorem.characters(number:6, min_numeric: 6).insert(3,"-")
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'postal_codeが9文字以上だと登録できない' do
        @address.postal_code = Faker::Lorem.characters(number:8, min_numeric: 8).insert(3,"-")
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @address.phone_number = Faker::Lorem.characters(number:9, min_numeric: 9)
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @address.phone_number = Faker::Lorem.characters(number:12, min_numeric: 12)
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'phone_numberに英字が存在すると登録できない' do
        @address.phone_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is not a number")
      end
      it 'fax_numberが9桁以下だと登録できない' do
        @address.fax_number = Faker::Lorem.characters(number:9, min_numeric: 9)
        @address.valid?
        expect(@address.errors.full_messages).to include("Fax number is too short (minimum is 10 characters)")
      end
      it 'fax_numberが12桁以上だと登録できない' do
        @address.fax_number = Faker::Lorem.characters(number:12, min_numeric: 12)
        @address.valid?
        expect(@address.errors.full_messages).to include("Fax number is too long (maximum is 11 characters)")
      end
      it 'fax_numberに英字が存在すると登録できない' do
        @address.fax_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @address.valid?
        expect(@address.errors.full_messages).to include("Fax number is not a number")
      end
    end
  end
end
