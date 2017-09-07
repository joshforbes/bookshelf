FactoryGirl.define do
  factory :user, class: Users::User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    display_name { Faker::Name.name }

    trait :with_token do
      after(:create) do |user|
        create(:token, user: user)
      end
    end
  end
end
