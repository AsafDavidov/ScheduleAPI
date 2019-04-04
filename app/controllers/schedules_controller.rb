class SchedulesController < ApplicationController
  #+++++++++++++++++++++++++
  #Temporarily remove the authenticity token that is within rails in order to test cURL routes
  #skip_before_action :verify_authenticity_token, only: [:create,:destroy]
  #+++++++++++++++++++++++++
  #Controller render for /schedules
  def index
    @schedules = Schedule.all
    render json: @schedules, status: :ok
  end

  #Controller render for /schedule/1 witha minor error checking
  def show
    @schedule = Schedule.find_by_id(params[:id])
    if @schedule
      #schedule_appointments = @schedule.appointments
      render json: @schedule,status: :ok
    else
      render json: {errorMessage:"no schedule with id: #{params[:id]}"}, status: :not_found
    end
  end

  #create
  def create
    @schedule = Schedule.create(schedule_params)
    if @schedule.valid?
      render json: @schedule, status: :ok
    else
      render json: {errorMessage: "#{@schedule.errors.full_messages}"}
    end
  end

  #controller Destroy method
  #returns the remaining schedules if delete is successful
  def destroy
    @schedule = Schedule.find_by_id(params[:id])
    if @schedule
      @schedule.destroy
      @schedules = Schedule.all
      render json: @schedules
    else
      render json: {errorMessage:"no schedule with id: #{params[:id]}"}, status: :not_found
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name)
  end
end
