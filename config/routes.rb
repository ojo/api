require 'sidekiq/web'

Rails.application.routes.draw do

  get 'admin', to: 'admin#index'
  get 'admin/users', to: 'admin#users'

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
