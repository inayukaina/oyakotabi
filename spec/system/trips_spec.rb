require 'rails_helper'

RSpec.describe '旅行情報作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @trip_start_date = Date.today
    @trip_end_date = Date.today + 3
    @selected_prefecture = Prefecture.order("RAND()").first
  end

  context '旅行情報作成ができるとき'do
    it 'ログインしたユーザーは旅行情報を新規作成できる' do
      # ログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(trips_path)
      # 旅行情報新規作成ページへのボタンがあることを確認する
      expect(page).to have_content('新しい旅行を作成')
      # 新規作成ページに移動する
      visit new_trip_path
      # フォームに情報を入力する
      fill_in 'trip_start_date', with: @trip_start_date
      fill_in 'trip_end_date', with: @trip_end_date
      select @selected_prefecture.name, from: 'prefecture_ids_0'
      # 保存するとTripモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { Trip.count }.by(1)
      # トップページには先ほど作成した旅行情報が存在することを確認する
      expect(page).to have_content ("#{@trip_start_date}")
      # トップページの白地図は、先ほど作成した旅行情報と同じ県に色がついていることを確認する
      expect(page).to have_css("g#prefecture-#{@selected_prefecture.id}[style*='fill: rgb(42, 186, 108)']")
    end
  end
  context '旅行情報作成ができないとき'do
    it 'ログインしていないと旅行情報作成ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 旅行情報新規作成ページへのボタンがないことを確認する
      expect(page).to have_no_content('新しい旅行を作成')
      # 旅行情報新規作成ページに遷移する
      visit new_trip_path
      # ログイン画面にリダイレクトされることを確認する
      expect(page).to have_content('ログインもしくはアカウント登録してください。')
    end
  end
end

RSpec.describe '旅行情報編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @trip_start_date = Date.today
    @trip_end_date = Date.today + 3
    @selected_prefecture = Prefecture.order("RAND()").first
  end
  context '旅行情報編集ができるとき' do
    it 'ユーザーは旅行情報の編集ができる' do
      # ログインする
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
      # トップページから作成した旅行情報の詳細画面に遷移する
      visit trip_path(Trip.last)
      # 旅行情報に「編集」へのリンクがあることを確認する
      expect(page).to have_content('編集')
      # 旅行情報の編集画面に遷移する
      visit edit_trip_path(Trip.last)
      # すでに作成済みの内容がフォームに入っていることを確認する
      expect(page).to have_field('trip_start_date', with: @trip_start_date)
      expect(page).to have_field('trip_end_date', with: @trip_end_date)
      select @selected_prefecture.name, from: 'prefecture_ids_0'
      # 内容を編集する
      fill_in 'trip_start_date', with: Date.today + 1
      fill_in 'trip_end_date', with: Date.today + 4
      select '北海道', from: 'prefecture_ids_1'
      # 編集してもTripモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to_not change { Trip.count }
      # トップページには先ほど変更した内容の旅行情報が存在することを確認する
      expect(page).to have_content ("#{Date.today + 1}")
    end
  end
  context '旅行情報編集ができないとき' do
    it 'ログインしていないと旅行情報の編集画面には遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページには旅行情報詳細画面へのリンクがないことを確認する
      expect(page).to have_no_content('今までの旅行')
    end
  end
end

RSpec.describe '旅行情報削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @trip_start_date = Date.today
    @trip_end_date = Date.today + 3
    @selected_prefecture = Prefecture.order("RAND()").first
  end
  context '旅行情報削除ができるとき' do
    it 'ユーザーは旅行情報の削除ができる' do
      # ログインする
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
      # トップページから作成した旅行情報の詳細画面に遷移する
      sleep 1
      visit trip_path(Trip.last)
      # 旅行情報に「削除」へのリンクがあることを確認する
      expect(page).to have_content('削除')
      # 削除すると旅行情報の数が1減ることを確認する
      expect{
        find_link('削除').click
        sleep 1
      }.to change { Trip.count }.by(-1)
      # トップページには旅行情報の内容が存在しないことを確認する
      expect(page).to have_no_content ("#{@trip_start_date}")
    end
  end
  context '旅行情報削除ができないとき' do
    it 'ログインしていないと旅行情報の削除画面には遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページには旅行情報詳細画面へのリンクがないことを確認する
      expect(page).to have_no_content('今までの旅行')
    end
  end
end




def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end