class UsersController < ApplicationController

  def ranking
    @branches = Branch.all
    if params[:branch_id]
      @users = User.where("branch_id = ?", params[:branch_id]).sort { |a,b| 
        comp = b.total_points() <=> a.total_points() 
        comp.zero? ? (a.calculate_test_time <=> b.calculate_test_time) : comp
      }
    else
      @users = User.all.sort { |a,b| 
        comp = b.total_points() <=> a.total_points() 
        comp.zero? ? (a.calculate_test_time <=> b.calculate_test_time) : comp
      }
    end
  end
  
  def ranking_detail
    @user = User.find(params[:id])
  end

end