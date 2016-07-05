Rails.application.routes.draw do

  authenticate :user do
    
    get 'mycourses' => 'courses#course_list', :as => :course_list
    get 'mycourses/:id' => 'courses#course_details', :as => :course_details
    get 'mycourses/:course_id/u/:unit_id/l/:id' => 'lessons#show', :as => :mycourse_unit_lesson
    get 'mycourses/:course_id/u/:unit_id/l/:lesson_id/p/:id' => 'pages#show', :as => :mycourse_unit_lesson_page
    
    scope "/admin" do
      resources :questions
      resources :videos
      resources :groups      
      resources :users, except: [:index]
      resources :courses do
        resources :units do
          resources :lessons do
            resources :pages
          end
        end
      end

      get 'dashboard' => 'dashboard#index', :as => :dashboard
      get 'grades(/branch/:branch_id)' => 'dashboard#grades', :as => :grades
      get 'grades/user/:user_id/course/:course_id' => 'dashboard#grade_details', :as => :grade_details
      get 'grades/activities' => 'dashboard#list_activities_scorables', :as => :activities
      get 'users(/branch/:branch_id)' => 'users#index', :as => :users_index
      get 'ranking(/:branch_id)' => 'users#ranking', :as => :ranking
      get 'ranking_detail/:id' => 'users#ranking_detail', :as => :ranking_detail
      get 'enrollments(/branch/:branch_id)' => 'dashboard#enrollments', :as => :enrollments
      post 'saveEnrollments' => 'dashboard#save_enrollments', :as => :saveEnrollments
      get 'page_visibility' => 'dashboard#page_visibility', :as => :page_visibility
      post 'saveVisibility' => 'dashboard#saveVisibility', :as => :saveVisibility
    end
    
    post 'saveAnswer' => 'pages#saveAnswer'
    post 'saveAnswers' => 'pages#saveAnswers'
    post 'saveQuestion' => 'pages#saveQuestion'
    
    post 'changeUserStatus' => 'users#change_user_status'
    
    # TheComments routes
    concern   :user_comments,  TheComments::UserRoutes.new
    concern   :admin_comments, TheComments::AdminRoutes.new
    resources :comments, concerns:  [:user_comments, :admin_comments]    
    
    root :to => 'courses#course_list'    
    
  end
  
  get 'editor' => 'editor#video', :as => :video_editor
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: "users/registrations",
    sessions: "users/sessions" }
end
