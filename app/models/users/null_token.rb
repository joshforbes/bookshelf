module Users
  class NullToken
    def use
      false
    end

    def is_equal_to?(token_string)
      false
    end

    def method_missing(m, *args, &block)
      nil
    end
  end
end
