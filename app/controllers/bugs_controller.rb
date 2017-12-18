class BugsController < ApplicationController
  before_action :set_project, only: [:new, :create, :index]
  before_action :set_bug, only: [:show, :resolve]

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.build(bug_params)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    
  end

  def unassign
    BugUser.find(params[:bug_user_id]).destroy
  end

  def assign
    @bug_user = BugUser.create(assign_params)
  end

  def resolve
    @bug.update(status: I18n.t('resolved'))
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_bug
      @bug = Bug.find(params[:id])
    end

    def bug_params
      params.require(:bug).permit(:user_id, :title, :deadline, :bug_type, :status)
    end

    def assign_params
      params.permit(:user_id, :bug_id)
    end

    def unassign_params
      params.permit(:bug_user_id)
    end
end
