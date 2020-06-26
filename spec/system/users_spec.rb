require 'rails_helper'

RSpec.describe 'Users', type: :system do
  feature "Sign up with valid data" do
    let(:user) { FactoryBot.build("valid_user") }
    scenario "Success" do
      visit 'users/new'
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      expect do
        click_button 'Create my account'
      end.to change(User, :count)
      expect(find(".alert").text).to have_content 'Welcome to Instagram'
    end
  end

  feature "Sign up with invalid data" do
    let(:user) { FactoryBot.build("invalid_user") }
    scenario "Failed" do
      visit 'users/new'
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      expect do
        click_button 'Create my account'
      end.to_not change(User, :count)
      expect(find(".alert").text).to have_content 'The form contains'
    end
  end
end