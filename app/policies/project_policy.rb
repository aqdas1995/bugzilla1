class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def edit_update_destroy?
    manager? && @project.user.id == @user.id
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

  def creator?
    @user.id == @project.user_id if manager?
  end

  class Scope < Scope
    def manager?
      @user.user_type == 'Manager'
    end

    def sqa?
      @user.user_type == 'SQA'
    end

    def man_sqa?
      manager? || sqa?
    end

    def resolve
      if man_sqa?
        scope.all
      else
        query = Bug.select(:project_id).distinct(true).joins(:bug_users).where(bug_users: { user_id: @user.id.to_s })
        indices = query.pluck(:project_id)
        scope.find(indices)
      end
    end
  end
end
