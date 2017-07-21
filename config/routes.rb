Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  devise_for :users, class_name: 'FormUser',
             :controllers => { omniauth_callbacks: 'omniauth_callbacks',
                               registrations: 'registrations' }
  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end


  resources :item_groups do
    resources :comments
    resources :items
  end

  resources :comments do
    resources :comments
  end

  resources :items do
    member { post :vote }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
