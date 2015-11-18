class UsersController < ApplicationController

  def ranking
     @users = User.all.sort { |a,b| 
        comp = b.total_points() <=> a.total_points() 
        comp.zero? ? (a.calculate_test_time <=> b.calculate_test_time) : comp
     }
  end
  
  def ranking_detail
    @user = User.find(params[:id])
  end

end