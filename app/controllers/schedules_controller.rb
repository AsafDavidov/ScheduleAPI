class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
    render json: @schedules
  end

  def show
    @schedule = Schedule.find_by_id(params[:id])
    if @schedule
      render json: @schedule, status: :ok
    else
      render json: {errorMessage:"no schedule with id: #{params[:id]}"}, status: :not_found
    end
  end
end
