class Students::TracksController < ApplicationController
  def home
  end

  def performance
  end

  def tracks
    @tracks = Track.all
  end

  def resources
  end
end
