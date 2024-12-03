require 'rails_helper'

RSpec.describe ChildPackingItem, type: :model do
  before do
    # 必要なデータの作成
    @user = FactoryBot.create(:user) # ユーザーを作成
    @trip = FactoryBot.create(:trip, user_id: @user.id) # ユーザーを関連付けて旅行を作成
    @prefecture = FactoryBot.create(:prefecture) # 都道府県を作成
    @trip.prefectures << @prefecture # 旅行に都道府県を関連付ける
    @child_packing_item = FactoryBot.build(:child_packing_item, trip_id: @trip.id) # 旅行を関連付けて子供用荷物を作成
  end

  describe '子供用荷物の保存' do
    context '保存できるとき' do
      it 'nameとquantityが入力されていると保存できる' do
        expect(@child_packing_item).to be_valid
      end
    end

    context '保存できないとき' do
      it 'nameが空では保存できない' do
        @child_packing_item.name = nil
        @child_packing_item.valid?
        expect(@child_packing_item.errors.full_messages).to include("Name can't be blank")
      end

      it 'quantityが空では保存できない' do
        @child_packing_item.quantity = nil
        @child_packing_item.valid?
        expect(@child_packing_item.errors.full_messages).to include("Quantity is not a number")
      end

      it 'quantityが0以下では保存できない' do
        @child_packing_item.quantity = 0
        @child_packing_item.valid?
        expect(@child_packing_item.errors.full_messages).to include("Quantity must be greater than 0")
      end

      it 'quantityが負の値では保存できない' do
        @child_packing_item.quantity = -1
        @child_packing_item.valid?
        expect(@child_packing_item.errors.full_messages).to include("Quantity must be greater than 0")
      end

      it 'tripが関連付けられていない場合は保存できない' do
        @child_packing_item.trip = nil
        @child_packing_item.valid?
        expect(@child_packing_item.errors.full_messages).to include("Trip must exist")
      end
    end
  end
end
