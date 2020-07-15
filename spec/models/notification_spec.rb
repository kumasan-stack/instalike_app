require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "Validation" do
    let(:notification) { FactoryBot.build(:notification) }
    subject { notification }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "micropost_id" do
        it "is blank" do
          notification.micropost_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          notification.micropost_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "passive_user_id" do
        it "is blank" do
          notification.passive_user_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          notification.passive_user_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "active_user_id" do
        it "is blank" do
          notification.active_user_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          notification.active_user_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "activity" do
        it "is blank" do
          notification.activity = "  "
          is_expected.not_to be_valid
        end
      end
    end
  end
end
