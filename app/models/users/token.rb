module Users
  class Token
    EXPIRES = 7.days.ago

    def initialize(user)
      @user = user
    end

    def body
      @user.auth_token
    end

    def last_used_at
      @user.token_last_used_at
    end

    def regenerate
      @user.regenerate_auth_token
    end

    def active?
      @user.token_last_used_at >= EXPIRES
    end

    def use
      @user.token_last_used_at = Time.current
      @user.save!
      self
    end

    def compare_to(token)
      ActiveSupport::SecurityUtils.secure_compare(body, token)
    end
  end
end
