source 'https://rubygems.org'


gem 'active_model_serializers'
gem 'bootstrap-datepicker-rails'
gem 'chartkick'
gem 'devise'
gem 'dotenv-rails'
gem 'font-awesome-rails'
gem 'groupdate'
gem 'haml'
gem 'httparty'
gem 'ice_cube'
gem 'instagram'
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'omniauth'
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma', '~> 3.0' # Use Puma as the app server
gem 'rails', '>= 5.0.0.rc1', '< 5.1' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'recurring_select', git: 'git@github.com:briantigerchow/recurring_select.git', ref: '2d72656e8017c40aa8a1a95759862675266d7131'
gem 'redis'
gem 'redis-rails' ,"~> 5.0.0.pre"
gem 'rollbar'
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'simple_calendar', git: 'git@github.com:excid3/simple_calendar.git', branch: 'master'
gem 'sinatra', :require => nil, :git => 'git://github.com/sinatra/sinatra.git' # TODO(btc): use rubygems sinatra once bugfix is merged/released there (https://github.com/sinatra/sinatra/issues/1055)
gem 'twitter'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'with_advisory_lock'

# NOTE: Be sure to require rack_mini_profiler below the pg and mysql gems in
# your Gemfile. rack_mini_profiler will identify these gems if they are loaded
# to insert instrumentation. If included too early no SQL will show up.
gem 'rack-mini-profiler'

group :development, :test do
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-linked-files'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'foreman'
  gem 'guard'
  gem 'guard-minitest'
  gem 'haml-rails'
  gem 'listen'
  gem 'minitest-rails', git: 'git@github.com:blowmage/minitest-rails.git'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


source 'https://rails-assets.org' do
  gem 'rails-assets-jquery-ui'
  gem 'rails-assets-bootstrap'
end
