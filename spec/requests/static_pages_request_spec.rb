require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { "InstalikeApp" }

  it "is get root" do
    get root_url
    expect(response).to have_http_status(200)
    assert_select "title", "#{base_title}"
  end

  it "is get help" do
    get help_url
    expect(response).to have_http_status(200)
    assert_select "title", "Help | #{base_title}"
  end

  it "is get about" do
    get about_url
    expect(response).to have_http_status(200)
    assert_select "title", "About | #{base_title}"
  end

  it "is get contact" do
    get contact_url
    expect(response).to have_http_status(200)
    assert_select "title", "Contact | #{base_title}"
  end
end
