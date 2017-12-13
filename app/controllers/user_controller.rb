class UserController < ApplicationController
  def signup
    @user = User.new
    
  end
  
  def create
    @user = User.new(user_params)
    puts @user

    respond_to do |format|
      if @user.save
        puts "User Saved"
        format.html { redirect_to @user, notice: 'User Saved'}
      else
        puts @user.errors.any?
        error_msg = "Errors: " + @user.errors.count.to_s + "\n"
        @user.errors.full_messages.each do |msg|
          error_msg += (msg + "\n")
        end
        puts error_msg
        format.html {render :signup}
      end  
    end  
  end

  def login
  end

  def authentication
    @exists = User.where('email like ? AND password like ?', params[:email], params[:password]).count
    puts @exists.class
    if @exists == 1
      @user_logged = User.where('email like ? AND password like ?', params[:email], params[:password])
      puts @user_logged
    end
    puts params[:email]
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :user_type)
  end

end
