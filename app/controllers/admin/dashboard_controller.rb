class Admin::DashboardController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["assistant","teacher","admin"])
  end

  layout "admin"

  def index
  end

  def page_visibility
    @branches = Branch.all
    @courses = Course.all
  end

  def save_visibility
    status = "ok"
    message = "success"

    begin
      page_visibility = JSON.parse(params[:page_visibility])
      page_visibility.each do |page_visible|
        pv = PageVisibility.find_or_create_by(page_id: page_visible["page_id"],branch_id: page_visible["branch_id"])
        pv.status = page_visible["status"]
        pv.save
      end
    rescue => exception
      puts exception
      status = "fail"
      message = "We could not save the page visibility"
    end

    render :json => { :status => status, :message => message }
  end
end
