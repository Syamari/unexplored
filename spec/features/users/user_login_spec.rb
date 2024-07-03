require 'rails_helper'

RSpec.feature "ユーザーログイン", type: :feature do
  before do
    User.create!(user_name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
  end

  context '入力情報正常系' do
    it 'ユーザーがログインできること' do
      visit login_path
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "password123"
      click_button "ログイン"
      expect(page).to have_content "ログインしました"
    end
  end
end
