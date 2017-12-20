class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize (user, bug)
    @user = user
    @bug = bug
  end

  def manager?
    @user.user_type == 'Manager' ? true : false
  end

  def sqa?
    @user.user_type == 'SQA' ? true : false
  end

  def dev?
    @user.user_type == 'Developer' ? true : false
  end

  def man_sqa?
    manager? || sqa?
  end

  def man_dev?
    manager? || sqa?
  end

  def dev_sqa?
    sqa? || dev?
  end
  
  class Scope < Scope
    def resolve
    end
  end
end
