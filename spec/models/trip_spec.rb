require 'rails_helper'

RSpec.describe Trip, type: :model do
  before do
    user = FactoryBot.create(:user)
    @trip = FactoryBot.build(:trip, user_id: user.id)
    @prefecture = FactoryBot.create(:prefecture)
    @trip.prefectures << @prefecture
  end

  describe '旅行情報の登録' do
    context '旅行情報を登録できるとき' do
      it 'start_date、end_date,prefectureを入力すると登録できる' do
        expect(@trip).to be_valid
      end
    end

    context '旅行情報を登録できるとき' do
      it "start_dateが空では保存できない" do
        @trip.start_date = nil
        @trip.valid?
        expect(@trip.errors.full_messages).to include "Start date can't be blank"
      end
      it "end_dateが空では保存できない" do
        @trip.end_date = nil
        @trip.valid?
        expect(@trip.errors.full_messages).to include "End date can't be blank"
      end
      it "end_dateがstart_dateより後の場合は登録できない" do
        @trip.start_date = Date.today
        @trip.end_date = Date.today - 1
        @trip.valid?
        expect(@trip.errors.full_messages).to include "End date は開始日以降の日付を入力してください。"
      end
      it "prefectureは最低一つ選択しなければ登録できない" do
        @trip.prefectures = []
        @trip.valid?
        expect(@trip.errors.full_messages).to include "Prefectures は最低1つ選択してください。"
      end
      it 'prefectureが重複する場合は保存できない' do
        @trip.prefectures << @prefecture # すでに作成された `@prefecture` を再追加
        @trip.valid?
        expect(@trip.errors.full_messages).to include "Prefectures は重複して選択できません。"
      end
    end
  end
end
