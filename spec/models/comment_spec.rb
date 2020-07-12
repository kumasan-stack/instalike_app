require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Validation" do
    let(:comment) { FactoryBot.build(:comment) }
    subject { comment }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "micropost_id" do
        it "is blank" do
          comment.micropost_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          comment.micropost_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "user_id" do
        it "is blank" do
          comment.user_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          comment.user_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "content" do
        it "is blank" do
          comment.user_id = "  "
          is_expected.not_to be_valid
        end

        it "is too long" do
          comment.content = "a" * 51
          is_expected.not_to be_valid
        end
      end
    end
  end
end
