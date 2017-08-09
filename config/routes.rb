require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/index'
  get 'welcome/about'

  devise_for :users, class_name: 'FormUser',
             :controllers => { omniauth_callbacks: 'omniauth_callbacks',
                               registrations: 'registrations'}

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end


  resources :polls do
    resources :comments
    resources :options
    resources :reports
  end

  resources :comments do
    resources :comments
    resources :reports
    member { post :vote }
  end

  resources :options do
    member { post :vote }
  end

  namespace :admin do
    # get 'dashboard/index'
    get '', to: 'dashboard#index', as: '/'
    resources :polls
    resources :comments
    # mount Sidekiq::Web, at: '/sidekiq', :constraints => AdminConstraint.new
    authenticate :user, lambda { |user| user.admin == true } do
      mount Sidekiq::Web, at: '/sidekiq'
    end
    # mount Sidekiq::Web, at: "/sidekiq"
  end

  resources :user do
    resources :polls, only: :index
    resources :comments, only: :index
  end

  resources :feedback_messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
