require 'sidekiq/web'

Rails.application.routes.draw do

  scope :api do
    get 'timeline', to: 'timeline#index'
    post '/now-playing', to: 'now_playing#create'
    get 'auth/new'
  end

  namespace :admin do

    get '/', to: 'metrics#ttt'

    resources :managed_twitter_accounts, only: [:create, :update]
    resources :users
    resources :stations
    resources :managed_instagram_accounts, only: :update

    get 'programs/calendar', to: 'programs#calendar' # b4 :programs or else overridden by 'show'
    resources :programs

    get '/metrics/this-time-then', to: 'metrics#ttt'
    get '/metrics/index', to: 'metrics#index'
    get '/metrics/peak-times', to: 'metrics#peak_times'

    get 'users', to: 'administrators#list'

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


  root to: 'home#index'

  devise_for :users

end
