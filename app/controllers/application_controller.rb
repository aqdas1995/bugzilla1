class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from Exception::NoMethodError, :with => :render_error

  private

    def render_error
    render :file => "#{Rails.root}/public/dataundefined.html", :status => 404, :layout => false
    end

    def user_not_authorized
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

end
