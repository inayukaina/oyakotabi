require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  before do
    @prefecture = Prefecture.new(name: "東京都")
  end

  it 'nameがなければ無効である' do
    @prefecture.name = nil
    @prefecture.valid?
    expect(@prefecture.errors.full_messages).to include("Name can't be blank")
  end

  it 'nameが重複していれば無効である' do
    Prefecture.create!(name: '東京都')
    @prefecture.valid?
    expect(@prefecture.errors.full_messages).to include("Name has already been taken")
  end
end