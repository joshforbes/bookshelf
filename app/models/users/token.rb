module Users
  class Token < ApplicationRecord
    EXPIRES = 7.days.ago

    belongs_to :user, class_name: 'Users::User'

    scope :active, -> { where('last_used_at >= ?', EXPIRES) }

    has_secure_token :body

    def use
      return false unless active?

      update!(last_used_at: Time.current)
      true
    end

    def equal_to?(token_string)
      ActiveSupport::SecurityUtils.secure_compare(body, token_string)
    end

    private

    def active?
      last_used_at >= EXPIRES
    end
  end
end
