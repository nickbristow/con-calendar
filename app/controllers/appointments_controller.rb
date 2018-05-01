# frozen_string_literal: true

class AppointmentsController < ApplicationController
  after_action :update_event_attendee_count, only: %i[create destroy]
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    if @appointment.save
      flash[:success] = 'Joined!'
      if params[:appointment][:path]
        redirect_to params[:appointment][:path]
      else
        redirect_to :back
      end
    else
      flash[:error] = 'an error occurred'
      redirect_to :back
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    if params[:appointment][:path]
      redirect_to params[:appointment][:path]
    else
      redirect_to :back
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:event_id)
  end

  def update_event_attendee_count
    @appointment.event.update_attendee_count
  end
end
