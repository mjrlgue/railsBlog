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
