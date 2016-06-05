require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :admin do
    resources :managed_twitter_accounts, only: :create

    resources :users
    resources :stations

    get 'socialmedia', to: 'social_media_management#index'
    get 'schedule', to: 'schedules#index'
    get 'schedule/new', to: 'schedules#new'
    get 'schedule/list', to: 'schedules#list'

    resources :schedules, only: [:create]
  end
  if Rails.env.development?
    authenticate :user do
      mount Sidekiq::Web => '/admin/sidekiq'
    end
  else
    mount Sidekiq::Web => '/admin/sidekiq'
    # TODO(btc): set up admin-only access
  end

  get '/admin', to: 'admin#index'
  get 'admin/users', to: 'admin#users'

  scope '/api' do
    get 'auth/new'
  end

  root to: 'home#index'

  devise_for :users

end
