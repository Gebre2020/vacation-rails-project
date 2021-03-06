class LocationsController < ApplicationController
    before_action :redirect_if_not_logged_in?
    before_action :find_location, only: [:show, :update, :edit, :destroy]
    
    def index  
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @locations = @user.locations.all
      else
        flash[:message] = "The user doesn't exist" if params[:user_id]
        @locations = Location.all
      end
      # @locations = Location.city_selector(params[:location][:city]) if params[:location] && !params[:location][:city].blank?
    end

    def show
      redirect_to locations_path if !@location
    end

    def new   
      @location = Location.new
      @location.trips.build
      #@location.build_user    
    end

    def create 
      # @user = current_user
      @location = current_user.locations.build(location_params)
        if @location.save 
          redirect_to locations_path
        else
          render :new
        end
    end

    def edit
      redirect_to locations_path if !@location || @location.user != current_user
    end

    def update
      redirect_to locations_path if !@location || @location.user != current_user
      @location.update(location_params)
      if @location.valid?
        redirect_to location_path(@location)
      else
        render :edit
      end
    end

    def destroy
      @location.destroy 
      redirect_to locations_path
    end

  private
    def location_params
        params.require(:location).permit(:city, :country, :user_id, trips_attributes:[:budget, :travel_id, travel_attributes:[:name, :address]])
    end

    def find_location
      @location = Location.find(params[:id])
    end
end
