FactoryGirl.define do
  factory :user, class: Users::User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    display_name { Faker::Name.name }
  end
end
