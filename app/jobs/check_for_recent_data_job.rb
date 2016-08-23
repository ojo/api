class CheckForRecentDataJob < ApplicationJob

  def perform(*args)
    cases = [
      [NewsItem, 24.hours, "ojo-feedback@ttrn.org", 12.hours],
      [PlayEvent, 15.minutes, "ojo-feedback@ttrn.org", 1.hour],
    ]
    cases.each do |c|
      klass = c[0]
      period = c[1]
      recipient = c[2]
      notification_cooldown = c[3]


      time_of_last = klass.last.created_at
      if Time.now - time_of_last > period

        next if notification_cooldown_is_active(klass)
        NoNewDataMailer.create(klass: klass, since: time_of_last, recipient: recipient).deliver_now
        set_notification_cooldown(klass, notification_cooldown.to_i)
      end
    end
  end

  def set_notification_cooldown klass, ttl
    $redis.setex cooldown_key(klass), ttl, true
  end

  def notification_cooldown_is_active klass
    $redis.get(cooldown_key(klass)) != nil
  end

  def cooldown_key klass
      "#{klass}-notification-sent-recently"
  end

  class NoNewDataMailer < ApplicationMailer
    def create opts
      name = opts[:klass].model_name.human.downcase # must include ActiveRecord::Naming
      since = opts[:since]
      to = opts[:recipient]
      from = 'TTRN Admin <no-reply@ttrn.org>'
      subject = "Warning: Last #{name} created #{time_ago_in_words(since)} ago"
      body = "Is something wrong?"
      mail(to: to, from: from, subject: subject, body: body)
    end
  end
end
