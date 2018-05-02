# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @current_path = events_path
    @events = filter_events
    @users_events = current_user.events
    @user_appointments = current_user.appointments
  end

  def my_events
    @current_path = events_my_calendar_path
    @users_events = current_user.events
    @user_appointments = current_user.appointments
    @events = filter_events.select do |e|
      @users_events.include?(e) || e.owner_id == current_user.id
    end
    render 'my_calendar'
  end

  def show
    @event = Event.includes(:users).find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = 'saved'
      redirect_to @event
    else
      flash[:error] = 'an error occurred'
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy
    redirect_to events_path
  end

  private

  def filter_events
    Event.where(category: event_filter_categories).sort_by(&:start_time)
  end

  def event_filter_categories
    cat = []
    cat.push('official_event') if params[:official_event]
    cat.push('panel') if params[:panel]
    cat.push('game') if params[:game]
    cat.push('outing') if params[:outing]
    if cat.empty?
      ['official_event', 'panel', 'game', 'outing']
    else
      cat
    end
  end

  def event_params
    if params[:event][:owner_id].blank? || !current_user.admin?
      params[:event][:owner_id] = current_user.id
    end
    params.require(:event).permit(:name, :description, :date, :start_time, :end_time, :category, :max_attendees, :owner_id, :location)
  end
end
