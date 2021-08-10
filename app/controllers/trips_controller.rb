class TripsController < ApplicationController
    before_action :redirect_if_not_logged_in
    layout "trip"
    def index
        if params[:location_id] && @location = Location.find_by_id(params[:location_id])
           # nested
            @trips = @location.trips
           # @trips = Trip.where(location_id: params[:location_id]).order(:budget)
        else
            flash[:messaage] = "The Location does't exist"
            @trips = Trip.all
        end
    end

    def show
        @trip = Trip.find_by_id(params[:id])
    end

    def new
        @trip = Trip.new(location_id: params[:location_id])   
       # @trip.build_location 
        @trip.build_travel
    end

    def create
        @trip = Trip.new(trip_params)
        # byebug
        if @trip.save 
            redirect_to trip_path(@trip)
        else
            render :new
        end
        # byebug
    end

    def edit 
        @trip = Trip.find_by_id(params[:id])
    end

    def update
        @trip = Trip.find_by_id(params[:id])
        @trip.update(trip_params)
        if @trip.valid?
            redirect_to trip_path(@trip)
        else
            render :edit
        end
    end

    def destroy  
    end

    private
    def trip_params
        params.require(:trip).permit(:budget, :location_id, location_attributes: [:city, :country], travel_attributes: [:name, :address])
    end
end
        