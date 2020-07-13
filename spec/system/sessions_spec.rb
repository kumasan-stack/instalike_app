require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  feature "Login" do
    scenario "Operate login, post, delete, follow, unfollow and logout." do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:sample_user)
      visit '/'
      fill_in 'user_email',    with: user1.email
      fill_in 'user_password', with: user1.password

      # ログイン
      click_button "ログイン"
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_title "InstalikeApp"

      # 投稿
      click_link "写真投稿"
      attach_file "micropost_image", "#{Rails.root}/spec/images/valid_image.jpg"
      fill_in "micropost_content",    with: "test投稿"
      expect do
        click_button 'Post'
        expect(page).to have_selector "#micropost-1"
      end.to change(Micropost, :count)

      # お気に入り登録
      expect do
        click_button "☆"
        expect(page).to have_button "★"
      end.to change(Favorite, :count)

      # お気に入り解除
      expect do
        click_button "★"
        expect(page).to have_button "☆"
      end.to change(Favorite, :count)

      # コメント投稿
      fill_in 'comment_content',    with: "テスト中なのです"
      expect do
        click_button "Send"
        expect(page).to have_selector "#comment-1"
      end.to change(Comment, :count)

      # コメント削除
      within "#comment-1" do
        click_link "delete"
      end
      expect do
        page.accept_confirm "本当に削除しますか？"
        # ブロック内で完了メッセージの確認をすることにより処理完了を待機する
        expect(page).to have_content "Comment deleted"
      end.to change(Comment, :count)

      # 投稿削除
      within "#micropost-1" do
        click_link "delete"
      end
      expect do
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "Micropost deleted"
      end.to change(Micropost, :count)

      # フォロー
      user2 = FactoryBot.create(:sample_user)
      visit "/users/#{user2.id}"
      expect(page).to have_selector "#following", text: "0"
      expect(page).to have_selector "#followers", text: "0"
      expect do
        click_button "フォローする"
        expect(page).to have_selector "#following", text: "0"
        expect(page).to have_selector "#followers", text: "1"
      end.to change(Relationship, :count)

      # アンフォロー
      expect do
        click_button "フォロー中"
        expect(page).to have_selector "#following", text: "0"
        expect(page).to have_selector "#followers", text: "0"
      end.to change(Relationship, :count)

      # ログアウト
      click_on "ログアウト"
      expect(page).to have_content "Signed out successfully."
      expect(page).to have_title "InstalikeApp"
    end

    scenario "Try to login with invalid information" do
      visit '/'
      fill_in 'user_email',    with: ""
      fill_in 'user_password', with: "foo"

      click_button "ログイン"
      expect(page).to have_content "Invalid Email or password."
    end
  end
end