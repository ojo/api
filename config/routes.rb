require 'sidekiq/web'
require 'domain_constraint'

def route_frontend host
  reversed = host.split('.').reverse.join
  root to: "domains/#{reversed}/home#index", constraints: DomainConstraint.new(["#{host}.dev", host])
end

Rails.application.routes.draw do

  route_frontend 'www.96wefm.com'
  route_frontend 'www.ttrn.org'
  route_frontend 'www.star947tt.com'

  namespace :api do
    namespace :v0 do
      get 'timeline', to: 'timeline#index'

      resources :news_items, only: [:index]

      post '/now-playing/serato-dj', to: 'now_playing#create_serato_dj'
      post '/now-playing/csrds', to: 'now_playing#create_csrds'
    end
  end

  namespace :admin do

    get '/', to: 'metrics#ttt'

    resources :managed_twitter_accounts, only: [:create, :update]
    resources :news_items
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

  authenticate :user do # TODO(btc): set up admin-only access
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  devise_for :users

end
