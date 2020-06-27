require 'rails_helper'

RSpec.describe 'Users', type: :system do
  feature "Sign up" do
    let(:validuser)   { FactoryBot.build("valid_user") }
    let(:invaliduser) { FactoryBot.build("invalid_user") }

    scenario "Success" do
      visit 'users/new'
      fill_in 'user_name',                  with: validuser.name
      fill_in 'user_user_name',             with: validuser.user_name
      fill_in 'user_email',                 with: validuser.email
      fill_in 'user_password',              with: validuser.password
      fill_in 'user_password_confirmation', with: validuser.password_confirmation
      expect do
        click_button 'Create my account'
      end.to change(User, :count)
      expect(find(".alert").text).to have_content 'Welcome to Instagram'
    end

    scenario "Failed" do
      visit 'users/new'
      fill_in 'user_name',                  with: invaliduser.name
      fill_in 'user_user_name',             with: invaliduser.user_name
      fill_in 'user_email',                 with: invaliduser.email
      fill_in 'user_password',              with: invaliduser.password
      fill_in 'user_password_confirmation', with: invaliduser.password_confirmation
      expect do
        click_button 'Create my account'
      end.to_not change(User, :count)
      expect(find(".alert").text).to have_content 'The form contains'
    end
  end
end