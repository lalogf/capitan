class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def no_applicant_allowed
    if current_user.applicant?
      redirect_to selection_path
    end
  end

  def require_admin
    if current_user.student?
      redirect_to root_path, notice: 'No tienes permisos de administración.'
      return
    end
  end

end
