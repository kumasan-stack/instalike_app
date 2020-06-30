require 'rails_helper'

RSpec.describe 'Users', type: :system do
  feature "Sign up" do
    context "by valid user" do
      let(:user) { FactoryBot.build("valid_user") }

      before do
        visit 'users/signup'
        fill_in 'user_name',                  with: user.name
        fill_in 'user_user_name',             with: user.user_name
        fill_in 'user_email',                 with: user.email
        fill_in 'user_password',              with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation
      end

      scenario "User count is increase and success message is displayed" do
        expect{ click_button 'Create my account' }.to change(User, :count)
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "by invalid_user" do
      let(:user) { FactoryBot.build("invalid_user") }

      before do
        visit 'users/signup'
        fill_in 'user_name',                  with: user.name
        fill_in 'user_user_name',             with: user.user_name
        fill_in 'user_email',                 with: user.email
        fill_in 'user_password',              with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation
      end

      scenario "User count is same as before and error message is displayed" do
        expect{ click_button 'Create my account' }.to_not change(User, :count)
        expect(page).to have_content "エラーが発生したため ユーザ は保存されませんでした。"
      end
    end
  end
end