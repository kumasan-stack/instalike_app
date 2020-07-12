FactoryBot.define do
  factory :favorite do
    association :micropost
    user { micropost.user }
  end
end
