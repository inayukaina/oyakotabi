require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  before do
    @prefecture = Prefecture.first
  end

  it 'nameがなければ無効である' do
    @prefecture.name = nil
    @prefecture.valid?
    expect(@prefecture.errors.full_messages).to include("Name can't be blank")
  end

  it 'nameが重複していれば無効である' do
    duplicate_prefecture = Prefecture.new(name: @prefecture.name)
    duplicate_prefecture.valid?
    expect(duplicate_prefecture.errors.full_messages).to include("Name has already been taken")
  end
end