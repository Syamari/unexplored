require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
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
end
