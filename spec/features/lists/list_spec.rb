require 'rails_helper'

RSpec.feature "リスト", type: :feature do
  before do
    # ユーザーの作成とログイン
    user = User.create!(user_name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
    visit login_path
    fill_in "email", with: "test@example.com"
    fill_in "password", with: "password123"
    click_button "ログイン"
    expect(page).to have_content "ログインしました"

    @list1 = create(:list, user:)
    @list2 = create(:list, user:)
    ['Arctic Monkeys', 'Porcupine Tree', 'Portishead'].each do |artist_name|
      artist = create(:artist, name: artist_name)
      create(:list_artist, list: @list2, artist:)
    end

    ['Arctic Monkeys', 'Porcupine Tree'].each do |artist_name|
      artist = create(:artist, name: artist_name)
      create(:list_artist, list: @list1, artist:)
    end
  end

  context '正常系' do
    it "一覧ページで新規リストを作成する" do
      visit lists_path
      expect(page).to have_content "マイリスト一覧"
      click_button "新規リスト作成"
      expect(page).to have_content "新規リスト"
      fill_in "list_name", with: "New Test List"
      click_button "登録"
      expect(page).to have_content "New Test List"
    end

    it "リストにアーティストを追加する" do
      visit lists_path
      click_button "新規リスト作成"
      fill_in "list_name", with: "Add Artist List"
      click_button "登録"
      click_link "Add Artist List"
      fill_in 'artist-name-input', with: 'Arctic Monkeys'
      click_button 'このアーティストを追加'
      expect(page).to have_content('Arctic Monkeys')
    end

    xit "レコメンドの生成, 楽曲再生画面, レーティング" do
      visit lists_path
      click_link @list2.name
      click_button "おすすめ楽曲を取得 →"
      expect(page).to have_selector('iframe')
      click_button "レーティングを保存"
      expect(page).to have_content('レーティングを保存しました')
      visit rates_path
      song_name = Rate.first.song.name
      click_link song_name.to_s
      expect(page).to have_selector('iframe')
    end

    it "リストをブックマークし、ブックマーク一覧で確認する" do
      visit lists_path
      expect(page).to have_content "マイリスト一覧"
      click_link @list1.name
      expect(page).to have_content @list1.name
      click_button 'bookmark-button'
      visit '/lists?view=bookmarked'
      expect(page).to have_content @list1.name
    end

    it "ブックマークを解除し、ブックマーク一覧から消えることを確認する" do
      visit lists_path
      expect(page).to have_content "マイリスト一覧"
      click_link @list1.name
      expect(page).to have_content @list1.name
      click_button 'bookmark-button'
      visit '/lists?view=bookmarked'
      expect(page).to have_content @list1.name
      visit list_path(@list1)
      click_button 'bookmark-button'
      visit '/lists?view=bookmarked'
      expect(page).not_to have_content @list1.name
    end

    it "リストを公開し、公開リスト一覧で確認する" do
      visit edit_list_path(@list1)
      find('input[name="list[public]"][type="checkbox"]').set(false)
      click_button 'リスト名を保存する'
      visit '/lists?view=public'
      expect(page).to have_content @list1.name
    end

    it "リスト内のアーティスト名をクリックすると、そのアーティストのトップトラック視聴画面に遷移できる" do
      visit lists_path
      click_link @list1.name
      click_link 'Porcupine Tree'
      expect(page).to have_selector('iframe')
    end
  end

  context '異常系' do
    it "リスト名が未入力の場合、エラーメッセージが表示される" do
      visit lists_path
      click_button "新規リスト作成"
      fill_in "list_name", with: ""
      click_button "登録"
      expect(page).to have_content "リストの作成に失敗しました"
    end

    it "レコメンド時にアーティストが３人未満の場合はエラー" do
      visit lists_path
      click_link @list1.name
      click_button "おすすめ楽曲を取得 →"
      expect(page).to have_content "レコメンドを行うにはリスト内にアーティストが3人以上必要です"
    end
  end
end
