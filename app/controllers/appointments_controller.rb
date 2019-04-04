class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # first i find the nested schedule given the ID
    @schedule = Schedule.find_by_id(params[:schedule_id])
    if @schedule
      #Here is a quick check to make sure that the validations have passed
      @appointment = Appointment.new(appointment_params)
      @appointment[:schedule_id] = @schedule.id
      if @appointment.valid?
        #if the validations pass save the appointment
        @appointment.save
        render json: @appointment, status: :ok
      else
        render json: {errorMessage: "#{@appointment.errors.full_messages}"}
      end
    else
      render json: {errorMessage:"no schedule with id: #{params[:schedule_id]}"}, status: :not_found
    end

  end

  private
  def appointment_params
    params.require(:appointment).permit(:name,:end_time,:start_time)
  end
end
