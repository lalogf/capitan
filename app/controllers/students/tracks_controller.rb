class Students::TracksController < ApplicationController
  def home
  end

  def performance
  end

  def tracks
    @user = current_user
    @tracks = Track.all
  end

  def resources
  end
end
