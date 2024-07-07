require 'rails_helper'

RSpec.feature "ユーザー登録", type: :feature do
  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      visit new_user_path

      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password123"
      click_button "登録"
      expect(page).to have_content "ユーザー登録 & ログインしました"
    end
  end

  context '入力情報異常系' do
    it 'メールアドレスが未入力の場合、エラーメッセージが表示されること' do
      visit new_user_path
      fill_in "user_email", with: ""
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password123"
      click_button "登録"
      expect(page).to have_content "ユーザー登録に失敗しました"
    end

    it 'パスワードが未入力の場合、エラーメッセージが表示されること' do
      visit new_user_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: ""
      fill_in "user_password_confirmation", with: ""
      click_button "登録"
      expect(page).to have_content "ユーザー登録に失敗しました"
    end
  end
end
