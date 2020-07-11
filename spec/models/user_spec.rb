require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    let(:user) { FactoryBot.build(:user) }
    subject { user }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "name" do
        it "is blank" do
          user.name = "  "
          is_expected.not_to be_valid
        end

        it "is too long" do
          user.name = "a" * 51
          is_expected.not_to be_valid
        end
      end

      context "user_name" do
        it "is blank" do
          user.user_name = "  "
          is_expected.not_to be_valid
        end

        it "is too long" do
          user.user_name = "a" * 51
          is_expected.not_to be_valid
        end
      end

      context "email" do
        it "is blank" do
          user.email = "  "
          is_expected.not_to be_valid
        end

        it "is too long" do
          user.email = "a" * 244 + "@example.com"
          is_expected.not_to be_valid
        end

        it "is non-conformity" do
          invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
          invalid_addresses.each do |invalid_address|
            user.email = invalid_address
            is_expected.not_to be_valid
          end
        end

        it "is already registered" do
          duplicate_user = user.dup
          duplicate_user.save
          is_expected.not_to be_valid
        end
      end

      context "password" do
        it "is blank" do
          user.password = user.password_confirmation = " " * 6
          is_expected.not_to be_valid
        end

        it "is too short" do
          user.password = user.password_confirmation = "a" * 5
          is_expected.not_to be_valid
        end

        it "is too long" do
          user.password = user.password_confirmation = "a" * 51
          is_expected.not_to be_valid
        end
      end

      context "Optional data" do
        example "Too long site_url" do
          user.site_url = "a" * 256
          is_expected.not_to be_valid
        end

        example "Too long profile" do
          user.profile = "a" * 256
          is_expected.not_to be_valid
        end

        example "Too long phone_number" do
          user.phone_number = "0000-1111-2222"
          is_expected.not_to be_valid
        end
      end
    end
  end
end
