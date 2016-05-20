require 'sidekiq/web'

Rails.application.routes.draw do

  get 'admin', to: 'admin#index'
  get 'admin/users', to: 'admin#users'
  get 'admin/socialmedia', to: 'social_media_management#index'

  scope '/api' do
    get 'auth/new'
  end

  root to: 'home#index'

  devise_for :users

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  else
    # TODO(btc): set up admin-only access
  end
end
