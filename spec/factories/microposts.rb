FactoryBot.define do
  factory :micropost do
    image { Rack::Test::UploadedFile.new("spec/images/valid_image.jpg") }
    association :user
  end
end
