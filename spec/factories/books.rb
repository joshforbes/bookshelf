FactoryGirl.define do
  factory :book, class: Books::Book do
    owner_id nil
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

    trait :with_owner do
      after(:create) do |book|
        book.update(owner: create(:user))
      end
    end
  end
end
