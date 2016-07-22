# Be sure to restart your server when you modify this file.

# Configure SSL options to enable HSTS with subdomains.
# FIXME: see https://github.com/rails/rails/issues/25918
Rails.application.config.ssl_options.deep_merge! hsts: { subdomains: true }
