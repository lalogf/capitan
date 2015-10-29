Rails.application.routes.draw do
  resources :courses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root :to => 'courses#index'
end
