FactoryBot.define do
  factory "valid_user", class: User do
    name { "Sample User" }
    user_name { "Sampling" }
    email { "sample@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory "invalid_user", class: User do
    name { "" }
    user_name { "" }
    email { "user@invalid" }
    password { "foo" }
    password_confirmation { "bar" }
  end
end