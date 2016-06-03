# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'ttrn-transactionals',
  :password => ENV.fetch('SENDGRID_PASSWORD'),
  :domain => 'ttrn.org',
  :address => 'smtp.sendgrid.net',
  :port => 2525, # required for GCE: https://cloud.google.com/compute/docs/tutorials/sending-mail/using-sendgrid
  :authentication => :plain,
  :enable_starttls_auto => true
}
