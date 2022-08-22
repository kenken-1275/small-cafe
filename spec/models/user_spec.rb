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
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。")
      end
      it '既に登録済みのemailでは登録できない' do
        @user.save
        ano_user = FactoryBot.build(:user)
        ano_user.email = @user.email
        ano_user.valid?
        expect(ano_user.errors.full_messages).to include("メールアドレスは既に使用されています。")
      end
      it 'emailは@がないと登録できない' do
        @user.email = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは有効でありません。")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "a1234"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上に設定して下さい。")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = '7a' + Faker::Internet.password(min_length: 129, mix_case: false)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以下に設定して下さい。")
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = "abcdef"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = "123456"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角数字を含むと登録できない' do
        @user.password = "１２３４５f"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordは全角英字を含むと登録できない' do
        @user.password = "12345F"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角で英字と数字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationは一致しないと登録できない' do
        @user.password_confirmation = "a12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationが内容とあっていません。")
      end
      it 'kanji_last_nameが空では登録できない' do
        @user.kanji_last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の姓が入力されていません。")
      end
      it 'kanji_last_nameが数字では登録できない' do
        @user.kanji_last_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の姓は全角文字を使用してください")
      end
      it 'kanji_last_nameが英字では登録できない' do
        @user.kanji_last_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の姓は全角文字を使用してください")
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の名が入力されていません。")
      end
      it 'kanji_first_nameが数字では登録できない' do
        @user.kanji_first_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の名は全角文字を使用してください")
      end
      it 'kanji_first_nameが英字では登録できない' do
        @user.kanji_first_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)の名は全角文字を使用してください")
      end
      it 'hiragana_last_nameが空では登録できない' do
        @user.hiragana_last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の姓が入力されていません。")
      end
      it 'hiragana_last_nameが漢字では登録できない' do
        @user.hiragana_last_name = "阿部"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の姓は全角かな文字を使用してください")
      end
      it 'hiragana_last_nameがカタカナでは登録できない' do
        @user.hiragana_last_name = "アベ"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の姓は全角かな文字を使用してください")
      end
      it 'hiragana_last_nameが数字では登録できない' do
        @user.hiragana_last_name = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の姓は全角かな文字を使用してください")
      end
      it 'hiragana_last_nameが英字では登録できない' do
        @user.hiragana_last_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の姓は全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが空では登録できない' do
        @user.hiragana_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の名が入力されていません。")
      end
      it 'hiragana_first_nameが漢字では登録できない' do
        @user.hiragana_first_name = "太朗"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の名は全角かな文字を使用してください")
      end
      it 'hiragana_first_nameがカタカナでは登録できない' do
        @user.hiragana_first_name = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の名は全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが数字では登録できない' do
        @user.hiragana_first_name = "１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の名は全角かな文字を使用してください")
      end
      it 'hiragana_first_nameが英字では登録できない' do
        @user.hiragana_first_name = "ABC"
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(かな)の名は全角かな文字を使用してください")
      end
    end
  end

  describe 'adminのバリデーション' do
    context 'adminが登録される' do
      it "adminの値が空欄の場合" do
        @user.admin = nil
        expect(@user).to be_valid
      end
      it "adminの値がfalseの場合" do
        @user.admin = false
        expect(@user).to be_valid
      end
    end
    context 'adminの登録がうまくいかないとき' do
      it "adminの値がtrueの場合" do
        @user.admin = true
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include("Adminシステムエラー：不正な値が入力されました")
      end
    end
  end
end
