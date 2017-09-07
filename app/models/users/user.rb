module Users
  class User < ApplicationRecord
    has_secure_password

    has_many :tokens, -> { active }, class_name: 'Users::Token'

    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 8 }, allow_nil: true
    validates :display_name, uniqueness: true, allow_nil: true

    def token_matching(body)
      tokens.to_a.find { |token| token.equal_to?(body) } || Users::NullToken.new
    end
  end
end
