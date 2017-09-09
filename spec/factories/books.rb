FactoryGirl.define do
  factory :book, class: Books::Book do
    isbn { Faker::Number.number(13) }
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    pages { Faker::Number.number(3) }
    published_year { Faker::Number.between(1900, 2017) }

    trait :with_rental do
      after(:create) do |book|
        create(:rental, book: book)
      end
    end
  end
end
