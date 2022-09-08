require 'rails_helper'

RSpec.describe StoreHoliday, type: :model do
  before do
    @store_holiday = FactoryBot.build(:store_holiday)
  end

  describe '店休日設定機能' do
    context '店休日設定できる時' do
      it '日付けが正しく入力出来ていれば登録できる' do
        expect(@store_holiday).to be_valid
      end
    end
    context '店休日設定できない時' do
      it 'store_holidayが空では登録できない' do
        @store_holiday.store_holiday = ""
        @store_holiday.valid?
        expect(@store_holiday.errors.full_messages).to include("店休日が入力されていません。")
      end
      it 'store_holidayが既に登録されている場合は登録できない' do
        @store_holiday.save
        ano_holiday = FactoryBot.build(:store_holiday)
        ano_holiday.store_holiday = @store_holiday.store_holiday
        ano_holiday.valid?
        expect(ano_holiday.errors.full_messages).to include("店休日は既に使用されています。")
      end
    end
  end
end
