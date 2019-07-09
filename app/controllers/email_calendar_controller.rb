# frozen_string_literal: true

class EmailCalendarController < ApplicationController
  def email_to
    return unless current_user.admin?

    puts '****emailed'
    @user = User.find(params[:id])
    if @user
      mail = UserMailer.notice_email(@user, 'GeeklyCon Schedule', '', get_users_events(@user), 'ALL')
      mail.deliver_later
    end
    redirect_to :back
  end

  def email_all
    @email_all_params = email_all_params
    return unless @email_all_params[:email_body]
    return unless @email_all_params[:day]
    return unless @email_all_params[:subject]
    return unless current_user.admin?

    users = if @email_all_params[:admin_only] == 'false'
              User.all
            else
              User.where(admin: true)
            end
    users.all.each do |user|
      events = get_users_events(user, @email_all_params[:day])
      mail = UserMailer.notice_email(
        user,
        @email_all_params[:subject],
        @email_all_params[:email_body],
        events,
        @email_all_params[:day]
      )
      mail.deliver_later
    end
    redirect_to :back
  end

  def index; end

  private

  def get_users_events(user, day = 'ALL')
    events = if day == 'ALL'
               user.all_events.where(date: Event.active_event_dates)
             else
               user.all_events.where(date: day)
             end
    format_user_events(events)
  end

  def format_user_events(events)
    render_to_string partial: 'email_calendar/email_events', locals: { events: events }
  end

  def email_all_params
    params.require(:email).permit(:day, :subject, :email_body, :admin_only)
  end
end
