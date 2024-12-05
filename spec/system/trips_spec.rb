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
      expect(page).to have_current_path(root_path)
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
      # トップページには先ほど作成した内容の旅行情報が存在することを確認する
      expect(page).to have_content ("#{@trip_start_date}")
      # トップページの先ほど作成した内容の旅行情報に対応した県に色がついていることを確認する
      expect(page).to have_css("g#prefecture-#{@selected_prefecture.id}[style*='fill: rgb(42, 186, 108)']")
    end
  end
  context '旅行情報作成ができないとき'do
    it 'ログインしていないと旅行情報作成ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 旅行情報新規作成ページへのボタンがないことを確認する
      expect(page).to have_no_content('新しい旅行を作成')
      # トップページに遷移する
      visit new_trip_path
      # ログイン画面にリダイレクトされることを確認する
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end