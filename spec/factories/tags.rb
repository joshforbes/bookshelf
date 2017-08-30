FactoryGirl.define do
  factory :tag, class: Tags::Tag do
    name { Faker::Book.genre }
  end
end
