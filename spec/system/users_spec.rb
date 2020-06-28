require 'rails_helper'

RSpec.describe 'Users', type: :system do
  feature "Sign up" do
    let(:valid_user)   { FactoryBot.build("valid_user") }
    let(:invalid_user) { FactoryBot.build("invalid_user") }

    scenario "Success" do
      visit 'users/new'
      fill_in 'user_name',                  with: valid_user.name
      fill_in 'user_user_name',             with: valid_user.user_name
      fill_in 'user_email',                 with: valid_user.email
      fill_in 'user_password',              with: valid_user.password
      fill_in 'user_password_confirmation', with: valid_user.password_confirmation
      expect do
        click_button 'Create my account'
      end.to change(User, :count)
      expect(find(".alert").text).to have_content "Welcome to Instagram"
    end

    scenario "Failed" do
      visit 'users/new'
      fill_in 'user_name',                  with: invalid_user.name
      fill_in 'user_user_name',             with: invalid_user.user_name
      fill_in 'user_email',                 with: invalid_user.email
      fill_in 'user_password',              with: invalid_user.password
      fill_in 'user_password_confirmation', with: invalid_user.password_confirmation
      expect do
        click_button 'Create my account'
      end.to_not change(User, :count)
      expect(find(".alert").text).to have_content "The form contains 5 errors"
    end
  end

  feature "Login" do

  end

  feature "Logout" do

  end
end