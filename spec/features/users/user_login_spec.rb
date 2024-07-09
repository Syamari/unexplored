require 'rails_helper'

RSpec.feature "ユーザーログイン", type: :feature do
  let(:user) { create(:user) }

  context '入力情報正常系' do
    it 'ユーザーがログインできること' do
      visit login_path
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "password123"
      click_button "ログイン"
      expect(page).to have_content "ログインしました"
    end
  end

  context '入力情報異常系' do
    it 'パスワードが未入力の場合、エラーメッセージが表示されること' do
      visit login_path
      fill_in "email", with: "test@example.com"
      fill_in "password", with: ""
      click_button "ログイン"
      expect(page).to have_content "ログインに失敗しました"
    end

    it 'メールアドレスが未入力の場合、エラーメッセージが表示されること' do
      visit login_path
      fill_in "email", with: ""
      fill_in "password", with: "password123"
      click_button "ログイン"
      expect(page).to have_content "ログインに失敗しました"
    end
  end
end
