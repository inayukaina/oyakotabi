require 'rails_helper'

RSpec.describe "荷物準備機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @trip_start_date = Date.today
    @trip_end_date = Date.today + 3
    @selected_prefecture = Prefecture.order("RAND()").first
  end

  it 'ユーザーは荷物リストを作成できる' do
    # ログインする
    basic_pass root_path
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    find('input[name="commit"]').click
    expect(page).to have_current_path(trips_path)
    # 旅行情報を作成する
    visit new_trip_path
    fill_in 'trip_start_date', with: @trip_start_date
    fill_in 'trip_end_date', with: @trip_end_date
    select @selected_prefecture.name, from: 'prefecture_ids_0'
    find('input[name="commit"]').click
    # 旅行情報詳細ページに遷移する
    visit trip_path(Trip.last)
    # 旅行情報詳細画面に荷物準備ページへのリンクがあることを確認する
    expect(page).to have_content('自分の荷物を準備しよう！')
    # 荷物準備ページへ遷移する
    visit trip_child_packing_items_path(Trip.last)
    # フォームに情報を入力する
    fill_in 'child_packing_item_name', with: '新規荷物'
    fill_in 'child_packing_item_quantity', with: 1
    # 追加するボタンをクリックすると、ChildPackingItemモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
      sleep 1
    }.to change { ChildPackingItem.count }.by(1)
    # 荷物準備ページにリダイレクトされることを確認する
    expect(page).to have_current_path(trip_child_packing_items_path(Trip.last))
    # 先ほど追加した荷物が表示されていることを確認する
    expect(page).to have_content('新規荷物')
  end
  it 'ユーザーは荷物リストを編集できる' do
    # ログインする
    basic_pass root_path
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    find('input[name="commit"]').click
    expect(page).to have_current_path(trips_path)
    # 旅行情報を作成する
    visit new_trip_path
    fill_in 'trip_start_date', with: @trip_start_date
    fill_in 'trip_end_date', with: @trip_end_date
    select @selected_prefecture.name, from: 'prefecture_ids_0'
    find('input[name="commit"]').click
    # 旅行情報詳細ページに遷移する
    sleep 1
    visit trip_path(Trip.last)
    # 荷物準備ページへ遷移する
    visit trip_child_packing_items_path(Trip.last)
    # 荷物リストを作成する
    fill_in 'child_packing_item_name', with: '新規荷物'
    fill_in 'child_packing_item_quantity', with: 1
    find('input[name="commit"]').click
    # 荷物リストに「編集」ボタンがあることを確認する
    expect(page).to have_content('編集')
    # 「編集」ボタンをクリックすると、荷物がフォームに再表示されることを確認する
    find('a', text: '編集').click
    expect(page).to have_content('新規荷物')
    # 内容を編集する
    fill_in 'child_packing_item_name', with: '編集済み荷物'
    # 「変更する」ボタンをクリックしても、ChildPackingItemモデルのカウントは変わらないことを確認する
    expect{
      find('input[name="commit"]').click
      sleep 1
    }.to_not change { ChildPackingItem.count }
    # 荷物準備ページにリダイレクトされることを確認する
    expect(page).to have_current_path(trip_child_packing_items_path(Trip.last))
    # 先ほど追加した荷物が表示されていることを確認する
    expect(page).to have_content('編集済み荷物')
  end

  it 'ユーザーは荷物リストを削除できる' do
    # ログインする
    basic_pass root_path
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    find('input[name="commit"]').click
    expect(page).to have_current_path(trips_path)
    # 旅行情報を作成する
    visit new_trip_path
    fill_in 'trip_start_date', with: @trip_start_date
    fill_in 'trip_end_date', with: @trip_end_date
    select @selected_prefecture.name, from: 'prefecture_ids_0'
    find('input[name="commit"]').click
    # 旅行情報詳細ページに遷移する
    sleep 1
    visit trip_path(Trip.last)
    # 荷物準備ページへ遷移する
    visit trip_child_packing_items_path(Trip.last)
    # 荷物リストを作成する
    fill_in 'child_packing_item_name', with: '新規荷物'
    fill_in 'child_packing_item_quantity', with: 1
    find('input[name="commit"]').click
    # 荷物リストに「削除」ボタンがあることを確認する
    expect(page).to have_content('削除')
    # 「削除」ボタンをクリックすると、ChildPackingItemモデルのカウントが1減ることを確認する
    expect{
      find_link('削除').click
      sleep 1
    }.to change { ChildPackingItem.count }.by(-1)
    # 荷物リストに先ほどの荷物が存在しないことを確認する
    expect(page).to have_no_content('新規荷物')
    # 荷物準備ページにリダイレクトされることを確認する
    expect(page).to have_current_path(trip_child_packing_items_path(Trip.last))
  end

end

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end