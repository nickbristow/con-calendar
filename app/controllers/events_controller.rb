class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = filter_events
    @users_events = current_user.events
  end

  def my_events
    @users_events = current_user.events
    @events = filter_events.select{|e|
      @users_events.include?(e) || e.owner_id == current_user.id
    }
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
      flash[:success] = "saved"
      redirect_to @event
    else
      flash[:error] = "an error occurred"
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
    if !event_filter_categories.empty?
      Event.where(category: event_filter_categories).sort_by{ |e| e.start_time }
    else
      Event.all.sort_by { |e| 
        if e.start_time
          e.start_time 
        else
          Time.now
        end
      }
    end
  end

  def event_filter_params
    params.permit(:official_event, :panel)
  end

  def event_filter_categories
    cat = []
    if params[:official_event]
      cat.push('official_event')
    end
    if params[:panel]
      cat.push('panel')
    end
    if params[:game]
      cat.push('game')
    end
    if params[:outing]
      cat.push('outing')
    end
    cat
  end

  def event_params
    if params[:event][:owner_id].blank? || !current_user.admin?
      params[:event][:owner_id] = current_user.id
    end
    params.require(:event).permit(:name, :description, :date, :start_time, :end_time, :category, :max_attendees, :owner_id)
  end
end
