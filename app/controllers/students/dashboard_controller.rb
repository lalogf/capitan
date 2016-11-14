class Students::DashboardController < ApplicationController
  def home
  end

  def performance
  end

  def tracks
    @user = current_user
    @sprint_badges = @user.sprint_badges.group_by(&:badge).map { |key,value| {key => value.size} }
    @sprint_badges[4] = nil if @sprint_badges.size < 5 #adds nil to the array

    @student_technical_points = { points: 1068, max: 1200 }
    @student_hse_points = { points: 984, max: 1200}

    @tracks = Track.all
  end

  def resources
  end
end
