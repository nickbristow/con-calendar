class UserMailer < ApplicationMailer
  def welcome_email(user, template)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def notice_email(user, subject, body, events, day)
    @user = user
    @body = body
    @events = events
    @day = day
    mail(to: @user.email, subject: subject)
  end
end
