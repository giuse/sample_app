
FactoryGirl.define do
  factory :user do
    # name      "Pluto il Cane"
    # email     "pluto@disney.com"
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "email.#{n}@example.com"}
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    # created_at Time.at(1.years.ago.to_f + rand * (Time.now.to_f - 1.years.ago.to_f))
    user
  end
end