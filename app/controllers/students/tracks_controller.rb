class Students::TracksController < ApplicationController
  def show
    @track = Track.find(params[:id] || 1)
    @levels = @track.courses.group_by(&:level)
  end
end
