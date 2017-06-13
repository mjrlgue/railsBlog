#users
User.create!(name: "Test user",
                    email: "example@something.com",
                    password: "helloworld",
                    password_confirmation: "helloworld",
                    admin: true)

#generate fake ID's
99.times do |n|
name = Faker::Name.name
email = "example#{n+1}@something.com"
password = "helloworld"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
end

#microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

#following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
following.each { |follower| follower.follow(user) }