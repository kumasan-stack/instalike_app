require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    let(:user) { FactoryBot.build("valid_user") }
    
    context "Valid Case" do
      example "Standard data" do
        expect(user).to be_valid
      end
    end

    context "Invalid Case" do
      example "Blank name" do
        user.name = "  "
        expect(user).not_to be_valid
      end

      example "Blank email" do
        user.email = "  "
        expect(user).not_to be_valid
      end

      example "Too long name" do
        user.name = "a" * 51
        expect(user).not_to be_valid
      end

      example "Too long email" do
        user.email = "a" * 256
        expect(user).not_to be_valid
      end

      example "Non-conformity email" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end

      example "Registered email" do
        duplicate_user = user.dup
        user.save
        expect(duplicate_user).not_to be_valid
      end

      example "Blank password" do
        user.password = user.password_confirmation = " " * 8
        expect(user).not_to be_valid
      end

      example "Too short password" do
        user.password = user.password_confirmation = "a" * 7
        expect(user).not_to be_valid
      end
    end
  end
end
