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
end
