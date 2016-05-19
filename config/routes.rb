require 'sidekiq/web'

Rails.application.routes.draw do

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
