module Users
  class OwnerSerializer < ActiveModel::Serializer
    attributes :id, :display_name
  end
end
