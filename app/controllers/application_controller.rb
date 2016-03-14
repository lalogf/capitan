class ApplicationController < ActionController::Base
  include TheComments::ViewToken
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def check_if_current_user_is_admin
    redirect_to root_path, notice: 'No tienes permisos de administración.' if !current_user.admin
  end
  
end
