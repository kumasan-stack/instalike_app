# Create a main sample user.
User.create!( name:                  "豊臣秀吉",
              user_name:             "サルゲッチュ",
              email:                 "example@railstutorial.org",
              password:              "password",
              password_confirmation: "password")

# Generate a bunch of additional users.
99.times do |n|
  name  =     Faker::Name.name
  user_name = Faker::Superhero.name
  email =     "example-#{n+1}@railstutorial.org"
  password =  "password"
  profile =   Faker::ChuckNorris.fact
  User.create!( name:                  name,
                user_name:             user_name,
                email:                 email,
                password:              password,
                password_confirmation: password,
                profile:               profile)
end

# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }