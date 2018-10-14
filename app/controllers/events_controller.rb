# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_filter_params, only: %i[index my_events]
  load_and_authorize_resource

  def index
    @current_path = events_path
    @events = filter_events
    @users_events = current_user.events
    @user_appointments = current_user.appointments
  end

  def my_events
    @current_path = events_my_calendar_path
    # owned_events = Event.where(owner_id: current_user.id, category: event_filter_categories).order(:start_time)
    # @users_events = (
    #   current_user.events.where(category: event_filter_categories).order(:start_time) +
    #   owned_events
    # ).uniq
    @user_appointments = current_user.appointments
    # @events = @users_events
    @events = current_user.all_events
    @users_events = @events
    render 'my_calendar'
  end

  def show
    @event = Event.includes(:users).find(params[:id])
    @event.update(current_attendees: @event.users.count)
    @users_events = current_user.events
    @user_appointments = current_user.appointments
    @my_event = @users_events.find { |e| e.id == @event.id } || @event.owner_id == current_user.id
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

  def load_filter_params
    @hide_full_games = filter_params[:hide_full_games].present?
  end

  def filter_params
    params.permit(:official_event, :panel, :game, :outing, :hide_full_games, :show_past_events)
  end

  def filter_events
    # Event.where(category: event_filter_categories).order(:start_time).order(:id)
    if !category_params.empty?
      Event.send_chain(category_params).order(:start_time).order(:id)
    else
      Event.all.order(:start_time).order(:id)
    end
  end

  def category_params
    if params[:show_past_events]
      params.permit(:official_event, :panel, :game, :outing).to_h.keys
    else
      keys = params.permit(:official_event, :panel, :game, :outing).to_h.keys
      keys.push(:hide_past_events)
    end
  end

  def event_filter_categories
    cat = []
    cat.push('official_event') if filter_params[:official_event]
    cat.push('panel') if filter_params[:panel]
    cat.push('game') if filter_params[:game]
    cat.push('outing') if filter_params[:outing]
    if cat.empty?
      %w[official_event panel game outing]
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
