require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { "InstalikeApp" }

  describe "GET #root" do
    before do
      get root_url
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end

    it "has correct title" do
      expect(response.body).to include "#{base_title}"
    end
  end

  describe "GET #terms" do
    before do
      get terms_url
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end

    it "has correct title" do
      expect(response.body).to include "利用規約 | #{base_title}"
    end
  end

  describe "GET #policy" do
    before do
      get policy_url
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end

    it "has correct title" do
      expect(response.body).to include "プライバシーポリシー | #{base_title}"
    end
  end
end
