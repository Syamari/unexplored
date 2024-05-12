require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  setup do
    User.create!(user_name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
    visit login_path
    fill_in "email", with: "test@example.com"
    fill_in "password", with: "password123"
    click_button "ログイン"
    expect(page).to have_content "ログインしました"
    @list_name = 'Test List'
  end

  scenario "一覧ページで新規リストを作成する" do
    visit lists_path
    expect(page).to have_content "マイリスト一覧"

    click_button "新規リスト作成"
    expect(page).to have_content "新規リスト"

    fill_in "list_name", with: @list_name
    click_button "登録"

    expect(page).to have_content @list_name
  end
end
