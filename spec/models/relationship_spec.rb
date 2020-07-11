require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "Validation" do
    let(:relationship) { FactoryBot.build(:relationship) }
    subject { relationship }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "follower_id" do
        it "is blank" do
          relationship.follower_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          relationship.follower_id = 1000
          is_expected.not_to be_valid
        end
      end

      context "followed_id" do
        it "is blank" do
          relationship.followed_id = nil
          is_expected.not_to be_valid
        end

        it "is not exist" do
          relationship.followed_id = 1000
          is_expected.not_to be_valid
        end
      end
    end
  end
end
