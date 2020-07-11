require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:base_title) { "InstalikeApp" }

  describe "GET #new" do
    before do
      get new_user_registration_url
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end

    it "has correct title" do
      expect(response.body).to include "ユーザー登録 | #{base_title}"
    end
  end
  
  describe "GET #show" do
    context "user exists" do
      before do
        @user = FactoryBot.create(:user)
        get user_url(@user)
      end

      it "is successful" do
        expect(response).to have_http_status(:success)
      end

      it "has correct title" do
        expect(response.body).to include "#{@user.name} | #{base_title}"
      end
    end

    context "user does not exist" do
      it "is error" do
        expect{ get user_url 1 }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
