FactoryBot.define do
  factory :notification do
    association :micropost
    passive_user { micropost.user }
    association :active_user, factory: :sample_user
    activity "Favorite"
  end
end
