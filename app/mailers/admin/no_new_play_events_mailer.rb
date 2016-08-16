class Admin::NoNewPlayEventsMailer < ApplicationMailer
  def since last_time
    to = 'ojo-feedback@ttrn.org'
    from = 'TTRN Admin <no-reply@ttrn.org>'
    subject = "Warning: Last play event received #{(Time.now - last_time) / 60} minutes ago"
    body = "Is something wrong?"
    mail(to: to, from: from, subject: subject, body: body)
  end
end
