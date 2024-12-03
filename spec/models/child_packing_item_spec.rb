require 'rails_helper'

RSpec.describe ChildPackingItem, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @trip = FactoryBot.build(:trip, user_id: @user.id)
    @child_packing_item = FactoryBot.build(:child_packing_item, trip: @trip)
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
