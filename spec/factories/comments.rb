FactoryBot.define do
  factory :comment do
    association :micropost
    user { micropost.user }
    content "テスト中ですよ"
  end
end
