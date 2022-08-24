require 'rails_helper'

RSpec.describe Reservation, type: :model do
  
  before do
    @reservation = FactoryBot.build(:reservation)
    @user = FactoryBot.create(:user)
    @reservation.user_id = @user.id
  end

  describe '予約管理機能' do
    context '予約新規登録できる時' do
      it '全ての情報が正しく入力出来ていれば登録できる' do
        expect(@reservation).to be_valid
      end
    end
    context ' 予約新規登録できない時' do
      it 'reservation_dateが空では登録できない' do
        @reservation.reservation_date = ""
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_dateが過去の日付では登録できない' do
        @reservation.reservation_date = "2022-08-20"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_dateが1ヶ月以上先の日付では登録できない' do
        @reservation.reservation_date = Faker::Date.between(from: Date.today + 32.days, to: Date.today + 60.days)
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_dateが月曜日の日付では登録できない' do
        @reservation.reservation_date = "2022-08-29"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_dateが火曜日の日付では登録できない' do
        @reservation.reservation_date = "2022-08-30"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_dateが水曜日の日付では登録できない' do
        @reservation.reservation_date = "2022-08-31"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約日は今日より１ヶ月以内の営業日を選択してください。")
      end
      it 'reservation_timeが空では登録できない' do
        @reservation.reservation_time = ""
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約時間が入力されていません。")
      end
      it 'reservation_timeが11:00~16:00以外では登録できない' do
        @reservation.reservation_time = "17:00"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約時間は選択肢から選んでください。")
      end
      it 'people_numberが空では登録できない' do
        @reservation.people_number = ""
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約人数が入力されていません。")
      end
      it 'people_numberが4人以上では登録できない' do
        @reservation.people_number = "4"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約人数は選択肢から選んでください。")
      end
      it 'people_numberが0人では登録できない' do
        @reservation.people_number = "0"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("予約人数は選択肢から選んでください。")
      end
      it 'tel_numberが空では登録できない' do
        @reservation.tel_number = ""
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("電話番号が入力されていません。")
      end
      it 'tel_numberが12桁以上では登録できない' do
        @reservation.tel_number = "123456789012"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("電話番号は正しく入力してください。")
      end
      it 'tel_numberが9桁以下では登録できない' do
        @reservation.tel_number = "123456789"
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("電話番号は正しく入力してください。")
      end
    end
  end
end
