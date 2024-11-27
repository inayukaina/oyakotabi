class TripsController < ApplicationController
  def index
    @trips = current_user.trips.includes(:prefectures)
    @visited_prefecture_ids = @trips.flat_map { |trip| trip.prefectures.pluck(:id) }.uniq
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to root_path
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :budget_total, :notes, prefecture_ids: []).merge(user_id: current_user.id)
  end
end
