require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  feature "Login" do
    let(:user) { FactoryBot.create(:user) }

    context "by valid_user" do
      before do
        visit '/'
        fill_in 'user_email',    with: user.email
        fill_in 'user_password', with: user.password
      end

      let(:flash_message) { "Signed in successfully." }

      scenario "push" do
        click_button "ログイン"
        expect(page).to have_content flash_message
        visit '/'
        expect(page).to_not have_content flash_message
      end
    end

    context "by invalid_user" do
      before do
        visit '/'
        fill_in 'user_email',    with: ""
        fill_in 'user_password', with: "foo"
      end

      let(:flash_message) { "Invalid Email or password." }

      scenario "push" do
        click_button "ログイン"
        expect(page).to have_content flash_message
        visit '/'
        expect(page).to_not have_content flash_message
      end
    end
  end
end