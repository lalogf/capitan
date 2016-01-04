Rails.application.routes.draw do

  authenticate :user do
    
    resources :courses, only: [:index,:show] do
      resources :units, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
        resources :pages
      end
    end    
    
    scope "/admin" do
      resources :questions
      resources :videos
      resources :users, except: [:index]
      resources :courses, except: [:index,:show] do
        resources :units do
          resources :pages, except: [:show]
        end    
      end
      
      get 'courses' => 'courses#admin', :as => :courses_admin
      get 'dashboard' => 'dashboard#index', :as => :dashboard
      get 'grades(/branch/:branch_id)' => 'dashboard#grades', :as => :grades
      get 'grades/activities' => 'dashboard#list_activities_scorables', :as => :activities
      get 'users(/branch/:branch_id)' => 'users#index', :as => :users_index
      get 'ranking(/:branch_id)' => 'users#ranking', :as => :ranking
      get 'ranking_detail/:id' => 'users#ranking_detail', :as => :ranking_detail      
      
    end
    
    post 'saveAnswer' => 'pages#saveAnswer'
    post 'saveQuestion' => 'pages#saveQuestion'   
    
    root :to => 'courses#index'    
    
  end
  
  get 'editor' => 'editor#video', :as => :video_editor
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: "users/registrations",
    sessions: "users/sessions" }
end
