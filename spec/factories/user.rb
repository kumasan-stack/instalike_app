FactoryBot.define do
  factory "valid_user", class: User do
    name                  { "Sample User" }
    user_name             { "Sampling" }
    email                 { "sample@example.com" }
    password              { "password" }
    password_confirmation { "password" }
    site_url              { "https://hoge.co.jp" }
    phone_number          { "000-1234-5678" }
    sex                   { "男性" }
    profile               { "テスト頑張ります" }
  end

  factory "invalid_user", class: User do
    name                  { "  " }
    user_name             { "  " }
    email                 { "user@invalid" }
    password              { "foo" }
    password_confirmation { "bar" }
    site_url              { "a" * 256 }
    phone_number          { "0000-1111-2222" }
    sex                   { "ABC" }
    profile               { "a" * 301 }
  end
end