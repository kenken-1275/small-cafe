require 'rails_helper'

RSpec.describe Announce, type: :model do
  before do
    @announce = FactoryBot.build(:announce)
  end

  describe 'お知らせ管理機能' do
    context 'お知らせ新規登録できる時' do
      it '全ての情報が正しく入力出来ていれば登録できる' do
        expect(@announce).to be_valid
      end
    end
    context ' お知らせ新規登録できない時' do
      it 'dateが空では登録できない' do
        @announce.date = ""
        @announce.valid?
        expect(@announce.errors.full_messages).to include("日付が入力されていません。")
      end
      it 'titleが空では登録できない' do
        @announce.title = ""
        @announce.valid?
        expect(@announce.errors.full_messages).to include("タイトルが入力されていません。")
      end
      it 'contentが空では登録できない' do
        @announce.content = ""
        @announce.valid?
        expect(@announce.errors.full_messages).to include("内容が入力されていません。")
      end
    end
  end

end
