require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー管理機能' do
    context 'ユーザー新規登録できる時' do
      it '全ての情報が正しく入力出来ていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '既に登録済みのemailでは登録できない' do
        @user.save
        ano_user = FactoryBot.build(:user)
        ano_user.email = @user.email
        ano_user.valid?
        expect(ano_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@がないと登録できない' do
        @user.email = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "a1234"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = '7a' + Faker::Internet.password(min_length: 129, mix_case: false)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = "abcdef"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = "123456"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角数字を含むと登録できない' do
        @user.password = "１２３４５f"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角英字を含むと登録できない' do
        @user.password = "12345F"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationは一致しないと登録できない' do
        @user.password_confirmation = "a12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'kanji_last_nameが空では登録できない' do
        @user.kanji_last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last name can't be blank")
      end
      it 'kanji_last_nameが数字では登録できない' do
        @user.kanji_last_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last name 全角文字を使用してください")
      end
      it 'kanji_last_nameが英字では登録できない' do
        @user.kanji_last_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last name 全角文字を使用してください")
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name can't be blank")
      end
      it 'kanji_first_nameが数字では登録できない' do
        @user.kanji_first_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name 全角文字を使用してください")
      end
      it 'kanji_first_nameが英字では登録できない' do
        @user.kanji_first_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name 全角文字を使用してください")
      end
      it 'hiragana_last_nameが空では登録できない' do
        @user.hiragana_last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana last name can't be blank")
      end
      it 'hiragana_last_nameが漢字では登録できない' do
        @user.hiragana_last_name = "阿部"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana last name 全角かな文字を使用してください")
      end
      it 'hiragana_last_nameがカタカナでは登録できない' do
        @user.hiragana_last_name = "アベ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana last name 全角かな文字を使用してください")
      end
      it 'hiragana_last_nameが数字では登録できない' do
        @user.hiragana_last_name = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana last name 全角かな文字を使用してください")
      end
      it 'hiragana_last_nameが英字では登録できない' do
        @user.hiragana_last_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana last name 全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが空では登録できない' do
        @user.hiragana_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana first name can't be blank")
      end
      it 'hiragana_first_nameが漢字では登録できない' do
        @user.hiragana_first_name = "太朗"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana first name 全角かな文字を使用してください")
      end
      it 'hiragana_first_nameがカタカナでは登録できない' do
        @user.hiragana_first_name = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana first name 全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが数字では登録できない' do
        @user.hiragana_first_name = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana first name 全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが英字では登録できない' do
        @user.hiragana_first_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("Hiragana first name 全角かな文字を使用してください")
      end
    end
  end
end
