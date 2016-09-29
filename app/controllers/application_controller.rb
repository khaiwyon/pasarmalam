class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:danger] = "You're not authorized"
    redirect_to request.referrer || main_app.root_path
  end


  def current_user
    return unless session[:id]
    @current_user ||= User.find_by(id: session[:id])
  end
  helper_method :current_user

private

   def authenticate!
    unless current_user
      message = "You need to login first"
      if request.format.html?
        flash[:danger] = message
      redirect_to root_path
    else
      flash.now[:danger] = message
      render "layouts/flash"
    end
  end
end

end
