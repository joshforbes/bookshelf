module Books
  class BookPolicy < ApplicationPolicy
    def create?
      @user.admin?
    end
  end
end
