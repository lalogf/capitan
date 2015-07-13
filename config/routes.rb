Rails.application.routes.draw do
  resources :courses
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  root :to => 'courses#index'
end
