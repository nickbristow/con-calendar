class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

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

  private

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
