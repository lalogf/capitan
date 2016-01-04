class DashboardController < ApplicationController

  layout "admin"

  def index
    
  end
  
  def grades
    @branches = Branch.all
    @branch_id = params[:branch_id] != nil ? params[:branch_id] : current_user.branch_id
    
    @courses = Course.all
    @courses_points_map = Hash[@courses.map { |course| [course.id,course.get_course_sum_points]}]
    
    @users = User.where("branch_id = ? and admin = 0",@branch_id)
    @users_score_by_course_map = Hash[@courses.map { |course|
     [course.id, Hash[User.total_score_by_course(course.id).map { |user| 
        [user.id, user.score] 
      }]
     ]}]
  end
  
  def list_activities_scorables
    user = User.find(params[:user_id])
    
    json = {
      user: {
        id: user.id,
        code: user.code,
        name: user.name,
        lastname1: user.lastname1,
        lastname2: user.lastname2
      },
      activities: []
    }    
    
    activities = user.list_activities_scorables(params[:course_id])
    activities.each do |activity|
      json[:activities].push({
        id: activity[1],
        title: activity[2],
        max_points: activity[3],
        questions_points: activity[4],
        auto_corrector: activity[5],
        score: activity[6],
        type: activity[7]
      })
    end
    respond_to do |format|
      format.json { render :json => json }
    end

  end

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