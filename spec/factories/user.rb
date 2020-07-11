FactoryBot.define do
  sequence :mail_numbering do |i|
    "sample#{i}@example.com"
  end

  factory :user do
    name                  { "Valid User" }
    user_name             { "ValidTest" }
    email                 { "valid@example.com" }
    password              { "password" }
    password_confirmation { "password" }
    site_url              { "https://hoge.co.jp" }
    phone_number          { "000-1234-5678" }
    sex                   { "男性" }
    profile               { "テスト頑張ります" }
  end

  factory :sample_user, class: User do
    name                  { "Sample User" }
    user_name             { "Sampling" }
    email                 { generate :mail_numbering }
    password              { "password" }
    password_confirmation { "password" }
  end
end