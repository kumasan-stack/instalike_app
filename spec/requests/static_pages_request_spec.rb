require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { "InstalikeApp" }

  context "Access" do
    example "root" do
      get root_url
      expect(response).to have_http_status(:success)
      assert_select "title", "#{base_title}"
    end

    example "help page" do
      get help_url
      expect(response).to have_http_status(:success)
      assert_select "title", "利用規約 | #{base_title}"
    end

    example "about page" do
      get about_url
      expect(response).to have_http_status(:success)
      assert_select "title", "About | #{base_title}"
    end

    example "contact page" do
      get contact_url
      expect(response).to have_http_status(:success)
      assert_select "title", "Contact | #{base_title}"
    end
  end
end
