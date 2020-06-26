require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:base_title) { "InstalikeApp" }

  it "is get new" do
    get new_user_url
    expect(response).to have_http_status(:success)
    assert_select "title", "Sign up | #{base_title}"
  end
end
