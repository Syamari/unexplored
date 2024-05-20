require 'rails_helper'

RSpec.feature "UserRegistrations", type: :feature do
  scenario "新規登録する" do
    visit new_user_path

    fill_in "user_user_name", with: "Test User"
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    click_button "登録"

    expect(page).to have_content "ユーザー登録 & ログインしました"
  end
end
