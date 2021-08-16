class TripsController < ApplicationController
    before_action :redirect_if_not_logged_in?
    before_action :find_trip, only: [:show, :update, :edit, :destroy]
    layout "trip" 
    def index    
        if params[:location_id] && @location = Location.find_by_id(params[:location_id])
            # nested
            @trips = @location.trips
            # @trips = @location.trips.limit(1)
            # @trips = Trip.where(location_id: params[:location_id]).order(:budget)
        else
            
            @trips = Trip.order_by_budget
        end 
        
        
    end

    def show
        if params[:location_id]
            @trip = Location.find_by_id(params[:location_id]).trips.find_by_id(params[:id])
        else
           # @trip = Trip.find(params[:id])
        end
    end 

    def most_expensive  # custom routing
        # @trips = Trip.order_by_price
        # @trips = Trip.order_by_price.most_expensive
        @trips = Trip.most_expensive.order_by_price
        render :index, layout: "random"
    end

    def new
        if params[:location_id] && @location = Location.find_by_id(params[:location_id])
            @trip = Trip.new(location_id: params[:location_id])  # or
            # @trip = @location.trips.build
             @trip.build_travel
        else
            @trip = Trip.new
            @trip.build_location 
            @trip.build_travel
        end
    end

    def create
        @trip = Trip.new(trip_params)
        if params[:location_id]
            @location = Location.find_by_id(params[:location_id])
        end
        if @trip.save 
            redirect_to trip_path(@trip)
        else
            render :new
        end
        # byebug
    end

    def edit 
        if params[:location_id]
            location = Location.find_by(id: params[:location_id])
            if location.nil?
              redirect_to locations_path, alert: "Location not found."
            else
              @trip = location.trips.find_by(id: params[:id])
              redirect_to location_trips_path(location), alert: "Trip not found." if @trip.nil?
            end
        else
            #@trip = Trip.find(params[:id])
        end
    end

    def update
        @trip.update(trip_params)
        if @trip.valid?
            redirect_to trip_path(@trip)
        else
            render :edit
        end
    end

    # def destroy
    #     @trip.destroy 
    #     redirect_to trips_path 
    # end

    private
     
    def trip_params
        params.require(:trip).permit(:budget, :location_id, location_attributes: [:city, :country], travel_attributes: [:name, :address])
    end
    
    def find_trip
        @trip = Trip.find(params[:id])
    end
end
        