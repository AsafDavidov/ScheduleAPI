class AppointmentsController < ApplicationController
  #+++++++++++++++++++++++++
  #Temporarily remove the authenticity token that is within rails in order to test cURL routes
  skip_before_action :verify_authenticity_token, only: [:create,:destroy]
  #+++++++++++++++++++++++++

  #commented out show and index for appointments for full restful interactions
  #remmber to add routes
  # def index
  #   @appointments = Appointment.all
  #   render json: @appointments, status: :ok
  # end
  # def show
  #   @schedule = Schedule.find_by_id(params[:schedule_id])
  #   if @schedule
  #     @appointment = Appointment.find_by_id(params[:id])
  #     if @appointment
  #       render json: @appointment,status: :ok
  #     else
  #       render json: {errorMessage:"no appointment with id: #{params[:id]}"}, status: :not_found
  #     end
  #   else
  #     render json: {errorMessage:"no schedule with id: #{params[:schedule_id]}"}, status: :not_found
  #   end
  # end

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


  #Optional destroy appointments since it was mentioned in the Supported requests but not
  #in the appointment model description
  def destroy
    @schedule = Schedule.find_by_id(params[:schedule_id])
    if @schedule
      #Here is a quick check to make sure that the validations have passed
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment
        #if the validations pass save the appointment
        @appointment.destroy
        render json: @schedule, status: :ok
      else
        render json: {errorMessage: "no appointment with id: #{@appointment.errors.full_messages}"}
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
