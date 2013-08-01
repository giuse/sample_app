namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  User.create!(name: "Example Admin",
             email: "a@t.c",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

  35.times do |n|
    User.create!(name: Faker::Name.name,
                 email: Faker::Internet.email,
                 password: "password",
                 password_confirmation: "password",
                 admin: false)
  end
end

def make_microposts
  users = User.all(limit: 6)
  35.times do |n|
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end

end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed)}
  followers.each      { |follower| follower.follow!(user) }
end