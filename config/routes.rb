Rails.application.routes.draw do
  
  resources :questions
  resources :videos
  resources :courses do
    resources :units do
      resources :pages
    end
  end
  
  get 'editor' => 'editor#video', :as => :video_editor
  get 'ranking' => 'users#ranking', :as => :ranking
  get 'ranking_detail/:id' => 'users#ranking_detail', :as => :ranking_detail
  
  post 'saveAnswer' => 'pages#saveAnswer'
  post 'saveQuestion' => 'pages#saveQuestion'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: "users/registrations",
    sessions: "users/sessions" }
  
  root :to => 'courses#index'
end
