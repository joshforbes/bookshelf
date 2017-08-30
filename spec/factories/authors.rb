FactoryGirl.define do
  factory :author, class: Authors::Author do
    name { Faker::Name.name }
  end
end
