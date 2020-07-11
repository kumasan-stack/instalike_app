require 'rails_helper'

RSpec.describe 'Resistrations', type: :system do
  feature "Sign up" do
    context "by valid user" do
      let(:user) { FactoryBot.build(:user) }

      scenario "Operate sign up, profile edit, password edit and user delete" do
        # Sign upページにアクセス、フォーム入力
        visit 'users/signup'
        fill_in 'user_name',                  with: user.name
        fill_in 'user_user_name',             with: user.user_name
        fill_in 'user_email',                 with: user.email
        fill_in 'user_password',              with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation

        # ユーザー登録（DB登録成功、リダイレクト成功、flash表示の確認)
        expect{ click_button 'Create my account' }.to change(User, :count)
        expect(page.title).to eq "#{user.name} | InstalikeApp"
        expect(page).to have_selector ".alert-success", text: "Welcome to Instagram."
        
        #プロフィール編集(編集可能な全項目変更後、値の確認)
        click_on 'プロフィール編集'
        fill_in 'user_name',                  with: "changed name"
        fill_in 'user_user_name',             with: "changed username"
        fill_in 'user_email',                 with: "change@foobar.com"
        fill_in 'user_phone_number',          with: "000-0000-0000"
        select  "その他",                      from: "user_sex"
        fill_in 'user_site_url',              with: "https://test.com"
        fill_in 'user_profile',               with: "test中です"
        click_button '更新'
        changed_user = User.first
        expect(changed_user.name).to         eq "changed name"
        expect(changed_user.user_name).to    eq "changed username"
        expect(changed_user.email).to        eq "change@foobar.com"
        expect(changed_user.phone_number).to eq "000-0000-0000"
        expect(changed_user.sex).to          eq "その他"
        expect(changed_user.site_url).to     eq "https://test.com"
        expect(changed_user.profile).to      eq "test中です"
        expect(page).to have_selector ".alert-success", text: "Your account has been updated successfully."
        expect(page.title).to eq "#{changed_user.name} | InstalikeApp"

        # パスワード編集(パスワード変更後、flashの確認)
        click_on 'プロフィール編集'
        click_on 'パスワード変更'
        fill_in 'user_current_password',      with: user.password
        fill_in 'user_password',              with: "change"
        fill_in 'user_password_confirmation', with: "change"
        click_button '更新'
        expect(page).to have_selector ".alert-success", text: "Your account has been updated successfully."
        expect(page.title).to eq "#{changed_user.name} | InstalikeApp"

        # ユーザー削除(アカウント削除ボタン、確認ダイアログOKプッシュ後にユーザー数が減少することの確認)
        click_on 'プロフィール編集'
        click_on 'アカウント削除'
        expect do
          page.accept_confirm "全てのデータが削除されますが本当によろしいですか?"
          # ブロック内で完了メッセージの確認をすることにより処理完了を待機する
          expect(page).to have_content "Bye! Your account has been successfully cancelled. We hope to see you again soon."
        end.to change(User, :count)
      end
    end

    context "by invalid_user" do
      scenario "User count is same as before and error message is displayed" do
        visit 'users/signup'
        fill_in 'user_name',                  with: "  "
        fill_in 'user_user_name',             with: "  "
        fill_in 'user_email',                 with: "invalid@cojp"
        fill_in 'user_password',              with: "foo"
        fill_in 'user_password_confirmation', with: "bar"
        # ユーザー登録失敗
        expect{ click_button 'Create my account' }.to_not change(User, :count)
        expect(page).to have_selector ".alert-danger", text: "The form contains 5 errors."
        expect(page.title).to eq "ユーザー登録 | InstalikeApp"
        expect(page).to have_field "user_email", with: "invalid@cojp"
      end
    end
  end
end