Rails.application.routes.draw do
  resources :courses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  
  root :to => 'courses#index'
end
