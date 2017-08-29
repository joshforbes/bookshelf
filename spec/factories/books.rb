FactoryGirl.define do
  factory :book, class: Books::Book do
    isbn { Faker::Number.number(13) }
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    pages { Faker::Number.number(3) }
    published_date { Faker::Date.between(50.years.ago, 1.year.ago) }
  end
end
