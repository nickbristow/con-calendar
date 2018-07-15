class UserMailer < ApplicationMailer
  def notice_email(user, subject, body, events, day)
    @user = user
    @body = body
    @events = events
    @day = day
    mail(to: @user.email, subject: subject)
  end
end
