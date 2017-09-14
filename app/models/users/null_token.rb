module Users
  class NullToken
    def user
      nil
    end

    def use
      false
    end

    def equal_to?(*)
      false
    end

    def active?
      false
    end
  end
end
