class DashboardController < ApplicationController

  layout "admin"

  def index
    
  end
  
  def grades
    @branches = Branch.all
    @branch_id = params[:branch_id] != nil ? params[:branch_id] : current_user.branch_id
    
    @courses = Course.all
    @courses_points_map = Hash[@courses.map { |course| [course.id,course.get_course_sum_points]}]
    
    @users = User.students(@branch_id)
    @users_score_by_course_map = Hash[@courses.map { |course|
     [course.id, Hash[User.total_score_by_course(course.id).map { |user| 
        [user.id, user.score] 
      }]
     ]}]
  end
  
  def grade_details
    @user = User.find(params[:user_id])
    @user_score = Hash[User.total_score_by_course(params[:course_id]).map { |user| [user.id, user.score] }]
    @editorAnswers = @user.getEditorAnswers(params[:course_id])
    @followUpQuestionAnswers = @user.getQuestionsAnswers(params[:course_id],false)
    @selfLearningQuestionAnswers = @user.getQuestionsAnswers(params[:course_id],true)
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
  
  def enrollments
    @branches = Branch.all
    @branch_id = params[:branch_id] != nil ? params[:branch_id] : current_user.branch_id
    
    @students = User.students(@branch_id)
    @courses = Course.all
  end
  
  def save_enrollments
    status = "ok"
    message = "success"
    
    begin
      params[:course_ids].each_with_index do |course_id, index|
        student_ids = JSON.parse(params[:student_ids])
        student_ids[index].each do |student_id|
          puts "course: #{course_id}, student: #{student_id}"
        end
      end
    rescue => exception
      puts exception.backtrace
      status = "fail"
      message = "We could not save the enrollments"    
    end
    
    render :json => { :status => status, :message => message }
  end
end