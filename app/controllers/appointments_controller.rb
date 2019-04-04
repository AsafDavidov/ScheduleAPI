class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all
    render json: @appointments, status: :ok
  end
  def show
    @schedule = Schedule.find_by_id(params[:schedule_id])
    if @schedule
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment
        render json: @appointment,status: :ok
      else
        render json: {errorMessage:"no appointment with id: #{params[:id]}"}, status: :not_found
      end
    else
      render json: {errorMessage:"no schedule with id: #{params[:schedule_id]}"}, status: :not_found
    end

  end

  def create
    @appointment = Appointment.create(appointment_params)
    if @appointment.valid?
      render json: @appointment, status: :ok
    else
      render json: {errorMessage: "#{@appointment.errors.full_messages}"}
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:name,:end_time,:start_time,:schedule_id)
  end
end
