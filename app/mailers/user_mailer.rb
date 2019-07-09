# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def notice_email(user, subject, body, events, day)
    @user = user
    @body = body
    @events = events
    @day = day
    @day_name = DateTime.strptime(@day, '%m/%d/%y').strftime("%A") if @day != 'All'
    mail(to: @user.email, subject: subject)
  end
end
