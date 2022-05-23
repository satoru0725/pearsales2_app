require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が入力されると登録できる' do
        expect(@user).to be_valid
      end
      it 'extended_addressが存在しなくても登録できる' do
        @user.extended_address = ""
        expect(@user).to be_valid
      end
      it 'fax_numberが存在しなくても登録できる' do
        @user.fax_number = ""
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'shop_nameが空では登録できない' do
        @user.shop_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Shop name can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'postal_codeが空では登録できない' do
        @user.postal_code = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefectureが空では登録できない' do
        @user.prefecture = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @user.city = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("City can't be blank")
      end
      it 'townが空では登録できない' do
        @user.town = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Town can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @user.phone_number = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = Faker::Internet.password(min_length: 4, max_length: 126) + "a0"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したshop_nameが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.shop_name = @user.shop_name
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Shop name has already been taken")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email.slice!("@")
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = Faker::Internet.password(min_length: 1,max_length: 5)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 130)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordが英字だけだと登録できない' do
        @user.password = Faker::Lorem.characters(number: 10, min_alpha: 10)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = Faker::Lorem.characters(number:10, min_numeric: 10)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数を両方含む必要があります")
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = Faker::Internet.username
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = Faker::Internet.username
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end
      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = Faker::Internet.username
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
      end
      it 'last_name_kanaが漢字では登録できない' do
        @user.last_name_kana = Gimei.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
      end
      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = Faker::Internet.username
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
      end
      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = Gimei.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
      end
      it 'postal_codeの4文字目に-(ハイフン)が存在しないと登録できない' do
        @user.postal_code = Faker::Lorem.characters(number:7, min_numeric: 7)
        @user.valid?
        expect(@user.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'postal_codeが7文字以下だと登録できない' do
        @user.postal_code = Faker::Lorem.characters(number:6, min_numeric: 6).insert(3,"-")
        @user.valid?
        expect(@user.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'postal_codeが9文字以上だと登録できない' do
        @user.postal_code = Faker::Lorem.characters(number:8, min_numeric: 8).insert(3,"-")
        @user.valid?
        expect(@user.errors.full_messages).to include("Postal code is invalid. Include hyphen(-) or Eenter a number in half-width")
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @user.phone_number = Faker::Lorem.characters(number:9, min_numeric: 9)
        @user.valid?
        expect(@user.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @user.phone_number = Faker::Lorem.characters(number:12, min_numeric: 12)
        @user.valid?
        expect(@user.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'phone_numberに英字が存在すると登録できない' do
        @user.phone_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @user.valid?
        expect(@user.errors.full_messages).to include("Phone number is not a number")
      end
      it 'fax_numberが9桁以下だと登録できない' do
        @user.fax_number = Faker::Lorem.characters(number:9, min_numeric: 9)
        @user.valid?
        expect(@user.errors.full_messages).to include("Fax number is too short (minimum is 10 characters)")
      end
      it 'fax_numberが12桁以上だと登録できない' do
        @user.fax_number = Faker::Lorem.characters(number:12, min_numeric: 12)
        @user.valid?
        expect(@user.errors.full_messages).to include("Fax number is too long (maximum is 11 characters)")
      end
      it 'fax_numberに英字が存在すると登録できない' do
        @user.fax_number[3] = Faker::Lorem.characters(number: 1, min_alpha: 1)
        @user.valid?
        expect(@user.errors.full_messages).to include("Fax number is not a number")
      end
    end
  end
end
