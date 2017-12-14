class UserController < ApplicationController
  def signup
    @user = User.new    
  end
  
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User Saved'}
      else
        format.html {render :signup}
      end  
    end  
  end

  def login
  end

  def authentication
    @exists = User.where('email = ? AND password = ?', params[:email], params[:password]).count
    if @exists == 1
      @user_logged = User.where('email = ? AND password = ?', params[:email], params[:password])
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :user_type)
  end

end
