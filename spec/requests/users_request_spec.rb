require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:base_title) { "InstalikeApp" }

  context "Access" do
    example "new page" do
      get new_user_url
      expect(response).to have_http_status(:success)
      assert_select "title", "ユーザー登録 | #{base_title}"
    end
  end
end
