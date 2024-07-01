require 'rails_helper'

RSpec.feature "リスト", type: :feature do
  before do
    User.create!(user_name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
    visit login_path
    fill_in "email", with: "test@example.com"
    fill_in "password", with: "password123"
    click_button "ログイン"
    expect(page).to have_content "ログインしました"
    @list_name = 'Test List'

    @list_name2 = 'Test List2'
    visit lists_path
    click_button "新規リスト作成"
    fill_in "list_name", with: @list_name2
    click_button "登録"
    click_link @list_name2
    fill_in 'artist-name-input', with: 'Arctic Monkeys'
    click_button 'このアーティストを追加'
    fill_in 'artist-name-input', with: 'Porcupine Tree'
    click_button 'このアーティストを追加'
    fill_in 'artist-name-input', with: 'Portishead'
    click_button 'このアーティストを追加'
  end

  context '入力情報正常系' do
    it "一覧ページで新規リストを作成する" do
      visit lists_path
      expect(page).to have_content "マイリスト一覧"
      click_button "新規リスト作成"
      expect(page).to have_content "新規リスト"
      fill_in "list_name", with: @list_name
      click_button "登録"
      expect(page).to have_content @list_name
    end

    it "リストにアーティストを追加する" do
      visit lists_path
      click_button "新規リスト作成"
      fill_in "list_name", with: @list_name
      click_button "登録"
      click_link @list_name
      fill_in 'artist-name-input', with: 'Arctic Monkeys'
      click_button 'このアーティストを追加'
      expect(page).to have_content('Arctic Monkeys')
    end

    it "レコメンドの生成, 楽曲再生画面, レーティング" do
      visit lists_path
      click_link @list_name2
      click_button "おすすめ楽曲を取得 →"
      expect(page).to have_selector('iframe')
      click_button "レーティングを保存"
      expect(page).to have_content('レーティングを保存しました')
      visit rates_path
      song_name = Rate.first.song.name
      click_link song_name.to_s
      expect(page).to have_selector('iframe')
    end
  end
end
