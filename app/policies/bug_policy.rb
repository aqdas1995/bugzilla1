class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  def own_project?
    manager? && @bug.project.user.id == @user.id
  end

  def create?
    if man_sqa?
      if manager?
        @bug.project.user.id == @user.id
      else
        true
      end
    end
  end

  def manager?
    @user.user_type == 'Manager'
  end

  def sqa?
    @user.user_type == 'SQA'
  end

  def dev?
    @user.user_type == 'Developer'
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
    def resolve; end
  end
end
