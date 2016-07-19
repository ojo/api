require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ttrn
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Eastern Time (US & Canada)'

    config.cache_store = :redis_store, File.join(ENV.fetch('REDIS_URL'), '/0/cache'), { expires_in: 90.minutes }

    config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
      bucket: ENV.fetch('S3_BUCKET'),
      access_key_id: ENV.fetch('S3_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY'),
      s3_region: 'us-east-1',
      }
    }
  end
end
