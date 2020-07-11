require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe "Validation" do
    let(:micropost) { FactoryBot.build(:micropost) }
    subject { micropost }

    describe "Valid Case" do
      it { is_expected.to be_valid }
    end

    describe "Invalid Case" do
      context "user_id" do
        it "is blank" do
          micropost.user_id = "  "
          is_expected.not_to be_valid
        end
      end

      context "content" do
        it "is too long" do
          micropost.content = "a" * 51
          is_expected.not_to be_valid
        end
      end

      context "image" do
        it "is nil" do
          micropost.image = nil
          is_expected.not_to be_valid
        end

        it "is invalid format" do
          micropost.image = Rack::Test::UploadedFile.new("spec/images/invalid_format.bmp")
          is_expected.not_to be_valid
        end

        it "is invalid format" do
          micropost.image = Rack::Test::UploadedFile.new("spec/images/over_filesize.jpg")
          is_expected.not_to be_valid
        end
      end
    end
  end
end
