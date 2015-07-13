class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  layout :select_layout_on_user_type
  
  protected
  
  def select_layout_on_user_type
    if current_user.try(:admin?)
      "admin"
    else
      "application"
    end
  end
  
end
