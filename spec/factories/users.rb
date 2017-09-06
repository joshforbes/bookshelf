FactoryGirl.define do
  factory :user, class: Users::User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    token_last_used_at DateTime.now
    display_name { Faker::Name.name }
  end
end
