FactoryGirl.define do
  factory :rental, class: Rentals::Rental do
    user
    book
    rented_at DateTime.now
    returned_at nil
  end
end
