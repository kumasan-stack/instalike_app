require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  feature "Login" do
    let(:user){ FactoryBot.create("valid_user") }

    context "by valid_user" do
      before do
        visit '/login'
        fill_in 'user_email',    with: user.email
        fill_in 'user_password', with: user.password
      end

      let(:flash_message) { "ログインしました。" }

      scenario "push" do
        click_button "ログイン"
        expect(page).to have_content flash_message
        visit '/login'
        expect(page).to_not have_content flash_message
      end
    end

    context "by invalid_user" do
      before do
        visit '/login'
        fill_in 'user_email',    with: ""
        fill_in 'user_password', with: "foo"
      end

      let(:flash_message) { "メールアドレスまたはパスワードが違います。" }

      scenario "push" do
        click_button "ログイン"
        expect(page).to have_content flash_message
        visit '/login'
        expect(page).to_not have_content flash_message
      end
    end
  end
end