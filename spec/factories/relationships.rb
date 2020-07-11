FactoryBot.define do
  factory :relationship do
    association :follower, factory: :user
    association :followed, factory: :sample_user
  end
end
