class Admin::PlayEventImageNotFoundMailer < ApplicationMailer
  def create h
    @play_event = h[:play_event]
    to = 'ojo-album-art@ttrn.org'
    from = "TTRN Admin <no-reply@ttrn.org>"
    s = "Couldn't find album art for #{@play_event.title} by #{@play_event.artist} on #{@play_event.station.tag}"
    b = %{
Here's the play event:

#{JSON.pretty_generate @play_event.as_json}
    }
    mail(from: from, to: to, subject: s, body: b)
  end
end
