module Rentals
  class RentalSerializer < ActiveModel::Serializer
    attributes :id, :rented_at, :returned_at

    has_one :book, serializer: Books::BookSerializer
    has_one :user, serializer: Users::OwnerSerializer
  end
end
