class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize (user, project)
    @user = user
    @project = project
  end

  def index?

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

  def creator?
    if manager?
      @user.id == @project.user_id
    end
  end

  class Scope < Scope
    def manager?
      @user.user_type == 'Manager' ? true : false
    end

    def sqa?
      @user.user_type == 'SQA' ? true : false
    end
    def man_sqa?
      manager? || sqa?
    end
    def resolve
      if man_sqa?
        scope.all
      else
        query = Bug.select(:project_id).distinct(true).joins(:bug_users).where(:bug_users => {user_id: "#{@user.id}"})
        indices = query.pluck(:project_id)
        scope.find(indices)
      end
    end
  end
end
