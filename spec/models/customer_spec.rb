require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    @customer = FactoryBot.build(:customer)
  end
  describe 'カスタマー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が入力されると登録できる' do
        expect(@customer).to be_valid
      end
      it 'extended_addressが存在しなくても登録できる' do
        @customer.extended_address = ''
        expect(@customer).to be_valid
      end
      it 'fax_numberが存在しなくても登録できる' do
        @customer.fax_number = ''
        expect(@customer).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @customer.nickname = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが空では登録できない' do
        @customer.password = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @customer.last_name = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @customer.first_name = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @customer.last_name_kana = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @customer.first_name_kana = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'postal_codeが空では登録できない' do
        @customer.postal_code = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefectureが空では登録できない' do
        @customer.prefecture = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @customer.city = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("City can't be blank")
      end
      it 'townが空では登録できない' do
        @customer.town = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Town can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @customer.phone_number = ''
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @customer.password = Faker::Internet.password(min_length: 4, max_length: 126) + 'a0'
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したnicknameが存在する場合は登録できない' do
        @customer.save
        another_customer = FactoryBot.build(:customer)
        another_customer.nickname = @customer.nickname
        another_customer.valid?
        expect(another_customer.errors.full_messages).to include('Nickname has already been taken')
      end
      it '重複したemailが存在する場合は登録できない' do
        @customer.save
        another_customer = FactoryBot.build(:customer)
        another_customer.email = @customer.email
        another_customer.valid?
        expect(another_customer.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @customer.email.slice!('@')
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @customer.password = Faker::Internet.password(min_length: 1, max_length: 5)
        @customer.password_confirmation = @customer.password
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @customer.password = Faker::Internet.password(min_length: 129, max_length: 130)
        @customer.password_confirmation = @customer.password
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordが英字だけだと登録できない' do
        @customer.password = Faker::Lorem.characters(number: 10, min_alpha: 10)
        @customer.password_confirmation = @customer.password
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'passwordが数字だけだと登録できない' do
        @customer.password = Faker::Lorem.characters(number: 10, min_numeric: 10)
        @customer.password_confirmation = @customer.password
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'last_nameが半角では登録できない' do
        @customer.last_name = Faker::Internet.username
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
      it 'first_nameが半角では登録できない' do
        @customer.first_name = Faker::Internet.username
        @customer.valid?
        expect(@customer.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'last_name_kanaが半角では登録できない' do
        @customer.last_name_kana = Faker::Internet.username
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end
      it 'last_name_kanaが漢字では登録できない' do
        @customer.last_name_kana = Gimei.last.kanji
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end
      it 'first_name_kanaが半角では登録できない' do
        @customer.first_name_kana = Faker::Internet.username
        @customer.valid?
        expect(@customer.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
      it 'first_name_kanaが漢字では登録できない' do
        @customer.first_name_kana = Gimei.first.kanji
        @customer.valid?
        expect(@customer.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
      it 'postal_codeの4文字目に-(ハイフン)が存在しないと登録できない' do
        @customer.postal_code = Faker::Lorem.characters(number: 7, min_numeric: 7)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Postal code is invalid. Include hyphen(-) or Eenter a number in half-width')
      end
      it 'postal_codeが7文字以下だと登録できない' do
        @customer.postal_code = Faker::Lorem.characters(number: 6, min_numeric: 6).insert(3, '-')
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Postal code is invalid. Include hyphen(-) or Eenter a number in half-width')
      end
      it 'postal_codeが9文字以上だと登録できない' do
        @customer.postal_code = Faker::Lorem.characters(number: 8, min_numeric: 8).insert(3, '-')
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Postal code is invalid. Include hyphen(-) or Eenter a number in half-width')
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @customer.phone_number = Faker::Lorem.characters(number: 9, min_numeric: 9)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @customer.phone_number = Faker::Lorem.characters(number: 12, min_numeric: 12)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'phone_numberに英字が存在すると登録できない' do
        @customer.phone_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Phone number is not a number')
      end
      it 'fax_numberが9桁以下だと登録できない' do
        @customer.fax_number = Faker::Lorem.characters(number: 9, min_numeric: 9)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Fax number is too short (minimum is 10 characters)')
      end
      it 'fax_numberが12桁以上だと登録できない' do
        @customer.fax_number = Faker::Lorem.characters(number: 12, min_numeric: 12)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Fax number is too long (maximum is 11 characters)')
      end
      it 'fax_numberに英字が存在すると登録できない' do
        @customer.fax_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Fax number is not a number')
      end
    end
  end
end
