FactoryGirl.define do
  factory :user, class: Users::User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    display_name { Faker::Name.name }
    is_admin false

    trait :admin do
      is_admin true
    end

    trait :with_token do
      after(:create) do |user|
        create(:token, user: user)
      end
    end
  end
end
