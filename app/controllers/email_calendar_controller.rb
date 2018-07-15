# frozen_string_literal: true

class EmailCalendarController < ApplicationController
  def email_to
    return unless current_user.admin?
    puts '****emailed'
    @user = User.find(params[:id])
    if @user
      UserMailer.notice_email(@user, 'Your Geekly Con Schedule', '', get_users_events(@user), 'ALL').deliver_now
    end
    redirect_to :back
  end

  def email_all
    @email_all_params = email_all_params
    return unless @email_all_params[:email_body]
    return unless @email_all_params[:day]
    return unless @email_all_params[:subject]
    return unless current_user.admin?
    User.all.each do |user|
      events = get_users_events(user, @email_all_params[:day])
      UserMailer.notice_email(
        user,
        @email_all_params[:subject],
        @email_all_params[:email_body],
        events,
        @email_all_params[:day]
      ).deliver_now
    end
    redirect_to :back
  end

  def index; end

  private

  def get_users_events(user, day = 'ALL')
    return user.all_events if day == 'ALL'
    user.all_events.where(date: day)
  end

  def email_all_params
    params.require(:email).permit(:day, :subject, :email_body)
  end
end
