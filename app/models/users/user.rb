module Users
  class User < ApplicationRecord
    has_secure_password
    has_secure_token :auth_token

    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 8 }, allow_nil: true
    validates :display_name, uniqueness: true, allow_nil: true
  end
end
