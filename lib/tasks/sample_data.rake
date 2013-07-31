namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example Admin",
                 email: "a@t.c",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    (40).times do |n|
      User.create!(name: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: "password",
                   password_confirmation: "password",
                   admin: false)
    end
  end
end