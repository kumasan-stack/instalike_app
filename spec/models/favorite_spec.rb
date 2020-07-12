require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "Validation" do
    let(:favorite) { FactoryBot.build(:favorite) }
    subject { favorite }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "micropost_id" do
        it "is blank" do
          favorite.micropost_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          favorite.micropost_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "user_id" do
        it "is blank" do
          favorite.user_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          favorite.user_id = 1000
          is_expected.not_to be_valid
        end
      end
    end
  end
end
