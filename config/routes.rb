require 'sidekiq/web'

Rails.application.routes.draw do

  scope :api do
    get 'timeline', to: 'timeline#index'
    post '/now-playing', to: 'now_playing#create'
    get 'auth/new'
  end

  namespace :admin do

    resources :managed_twitter_accounts, only: [:create, :update]
    resources :users
    resources :stations
    resources :managed_instagram_accounts, only: :update
    resources :programs, only: [:destroy]
    resources :schedules, only: [:create]

    get 'schedule', to: 'schedules#index'
    get 'schedule/new', to: 'schedules#new'
    get 'schedule/list', to: 'schedules#list'

    get 'socialmedia', to: 'social_media_management#index'
    get 'socialmedia/instagram_oauth_connect', to: 'social_media_management#instagram_oauth_connect'
    get 'socialmedia/instagram_oauth_callback', to: 'social_media_management#instagram_oauth_callback'
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

  root to: 'home#index'

  devise_for :users

end
