FactoryGirl.define do
  factory :rental, class: Rentals::Rental do
    user
    book
    rented_at Date.current
    returned_at nil
  end
end
