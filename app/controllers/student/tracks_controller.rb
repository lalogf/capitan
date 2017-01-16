class Student::TracksController < ApplicationController

  before_action do
    check_allowed_roles(current_user, ["student","assistant","teacher","admin"])
  end

  def show
    @track = Track.find(params[:id] || 1)
    @levels = @track.courses.group_by(&:level)
  end
end
