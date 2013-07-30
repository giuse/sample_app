
FactoryGirl.define do
  factory :user do
    # name      "Pluto il Cane"
    # email     "pluto@disney.com"
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "email.#{n}@example.com"}
    password  "foobar"
    password_confirmation "foobar"
  end
end