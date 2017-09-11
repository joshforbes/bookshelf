module Books
  class BookPolicy < ApplicationPolicy
    def create?
      @user.admin?
    end

    def delete?
      @user.admin?
    end
  end
end
