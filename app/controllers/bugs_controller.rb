class BugsController < ApplicationController
  before_action :set_project, only: %i[new create index]
  before_action :set_bug, only: %i[show resolve assign assignable_users]

  def new
    @bug = @project.bugs.build
    authorize @bug, :man_sqa?
  end

  def create
    @bug = @project.bugs.build(bug_params)
    authorize @bug, :man_sqa?
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

  def unassign
    authorize @bug, :dev?
    BugUser.find(params[:bug_user_id]).destroy
    flash[:notice] = 'User sucessfully assigned to the bug'
  end

  def assignable_users
    authorize @bug, :manager?
    @users = User.where(user_type: 'Developer')
  end

  def assign
    authorize @bug, :man_dev?
    check = BugUser.find_by(user_id: params[:user_id], bug_id: params[:bug_id])
    if check.nil?
      @bug_user = BugUser.create(assign_params)
      flash[:notice] = 'User sucessfully assigned to the bug'
    else
      flash[:notice] = 'User already added to the bug'
    end
  end

  def resolve
    authorize @bug, :dev?
    @bug.update(status: I18n.t('resolved'))
    flash[:notice] = 'User sucessfully assigned to the bug'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:user_id, :title, :deadline, :bug_type, :status, :image)
  end

  def assign_params
    params.permit(:user_id, :bug_id)
  end

  def unassign_params
    params.permit(:bug_user_id)
  end
end
